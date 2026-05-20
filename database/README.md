# Database Documentation

The TotemSense NPC database is stored in a platform-independent JSON format that can be compiled into different implementation formats (Plater, addon, WeakAura, etc.).

## Directory Structure

```
database/
├── tbc_raids.json           # TBC raid NPCs
├── tbc_dungeons.json        # TBC dungeon NPCs
├── classic_raids.json       # Classic raid NPCs
├── classic_dungeons.json    # Classic dungeon NPCs
├── generate_database.py     # Generates Lua code from JSON
└── build_constructor.py     # Builds Plater constructor with embedded database
```

## JSON Format

Each JSON file contains:

```json
{
  "metadata": {
    "expansion": "tbc|classic",
    "content_type": "raids|dungeons",
    "version": "2.0.0",
    "last_updated": "2026-05-02"
  },
  "npcs": {
    "<npc_id>": {
      "npc": "NPC Name",
      "instance": "Instance Name",
      "spells": [
        {
          "id": 12345,
          "name": "Spell Name",
          "type": "fear|charm|sleep"
        }
      ]
    }
  }
}
```

### Field Descriptions

| Field | Type | Description |
|-------|------|-------------|
| `metadata.expansion` | string | Game expansion: "classic" or "tbc" |
| `metadata.content_type` | string | Content type: "raids" or "dungeons" |
| `metadata.version` | string | Database version (semver) |
| `metadata.last_updated` | string | ISO date of last update |
| `npcs.<npc_id>` | object | NPC entry keyed by creature ID |
| `npc` | string | Display name of the NPC |
| `instance` | string | Instance/zone name where NPC is found |
| `spells` | array | List of spells cast by this NPC |
| `spells[].id` | number | WoW spell ID |
| `spells[].name` | string | Spell name |
| `spells[].type` | string | Effect type: "fear", "charm", or "sleep" |

## Usage

### 1. Validate Database

Check JSON syntax and view statistics:

```bash
python3 database/generate_database.py --format json
```

Output:
```
✓ Loaded tbc_raids.json: 14 NPCs
✓ Loaded tbc_dungeons.json: 22 NPCs
✓ Loaded classic_raids.json: 14 NPCs
✓ Loaded classic_dungeons.json: 21 NPCs

=== Database Validation ===
Total NPCs: 71
  Classic: 35
  TBC: 36
Spell Types:
  Fear: 52
  Charm: 13
  Sleep: 9
✓ Validation passed
```

### 2. Generate Lua Files

Generate Lua code for different platforms:

```bash
# Generate for Plater
python3 database/generate_database.py --format plater

# Generate for standalone addon
python3 database/generate_database.py --format addon

# Generate for WeakAura
python3 database/generate_database.py --format weakaura
```

**Output files:**
- `plater/database_generated.lua` - Compact inline format
- `addon_generated/Database.lua` - Structured return table
- `weakaura_generated/database.lua` - aura_env format

### 3. Build Plater Constructor

After generating the database, build the final constructor:

```bash
python3 database/build_constructor.py
```

This creates `plater/constructor.lua` with the embedded database, ready to copy into Plater.

### 4. Update Import String

After building the constructor, regenerate the import string:

```bash
cd plater
python3 generate_import_string.py > import_string.txt
```

## Adding New NPCs

### Step 1: Edit JSON File

Choose the appropriate file based on expansion and content type:

```bash
database/tbc_raids.json       # TBC raid bosses/trash
database/tbc_dungeons.json    # TBC dungeon encounters
database/classic_raids.json   # Classic 40/20-man raids
database/classic_dungeons.json # Classic 5-man dungeons
```

### Step 2: Add Entry

Add a new entry to the `npcs` object:

```json
{
  "npcs": {
    "12345": {
      "npc": "Example NPC",
      "instance": "Example Dungeon",
      "spells": [
        {"id": 67890, "name": "Fear", "type": "fear"}
      ]
    }
  }
}
```

For NPCs with multiple CC spells:

```json
"12345": {
  "npc": "Example Boss",
  "instance": "Example Raid",
  "spells": [
    {"id": 111, "name": "Fear", "type": "fear"},
    {"id": 222, "name": "Mind Control", "type": "charm"}
  ]
}
```

### Step 3: Validate

```bash
python3 database/generate_database.py --format json
```

Check for:
- ✅ JSON syntax errors
- ✅ Missing required fields
- ✅ Updated statistics

### Step 4: Generate Lua Files

```bash
python3 database/generate_database.py --format plater
python3 database/build_constructor.py
```

### Step 5: Test In-Game

1. Copy updated `plater/constructor.lua` to Plater
2. `/reload` in-game
3. Find the NPC and verify icon appears
4. Confirm Tremor Totem removes the effect

## Output Formats

### Plater Format (Compact Inline)

```lua
return {
  [12345] = { spells = {{id=67890, name="Fear", type="fear"}}, instance="Example", npc="Example NPC" },
}
```

**Usage:** Embedded in `plater/constructor.lua`

### Addon Format (Structured)

```lua
return {
  [12345] = {
    spells = {
      {id = 67890, name = "Fear", type = "fear"},
    },
    instance = "Example",
    npc = "Example NPC",
  },
}
```

**Usage:** Standalone WoW addon `Database.lua` file

### WeakAura Format (Compact)

```lua
aura_env.npcDatabase = {
  [12345]={spells={{id=67890,name="Fear",type="fear"}},instance="Example",npc="Example NPC"},
}
```

**Usage:** WeakAura custom code initialization

## Database Statistics

Current coverage (v2.0.0):

| Category | Count |
|----------|-------|
| **Total NPCs** | **71** |
| Classic Raids | 14 |
| Classic Dungeons | 21 |
| TBC Raids | 14 |
| TBC Dungeons | 22 |
| **Effect Types** | |
| Fear | 52 |
| Charm | 13 |
| Sleep | 9 |

## Future Expansions

To add support for WotLK Classic:

1. Create `database/wotlk_raids.json`
2. Create `database/wotlk_dungeons.json`
3. Follow the same JSON format
4. Run generation scripts as normal
5. The generator automatically includes all JSON files

## Maintenance Workflow

**When adding multiple NPCs:**

```bash
# 1. Edit JSON files
vim database/tbc_dungeons.json

# 2. Validate
python3 database/generate_database.py --format json

# 3. Generate all formats
python3 database/generate_database.py --format plater
python3 database/generate_database.py --format addon
python3 database/generate_database.py --format weakaura

# 4. Build Plater files
python3 database/build_constructor.py
cd plater && python3 generate_import_string.py > import_string.txt

# 5. Test in-game
```

## Benefits of JSON Source

✅ **Platform-independent** - Not tied to Lua syntax  
✅ **Easy to edit** - Clear structure, syntax highlighting  
✅ **Validated** - JSON parsers catch errors  
✅ **Version controlled** - Clean diffs in git  
✅ **Automated** - Generate multiple formats from single source  
✅ **Extensible** - Easy to add new implementations  
✅ **Documented** - Self-describing metadata  

## Schema Validation

The JSON format is self-documenting. Each file includes metadata:

```json
{
  "metadata": {
    "expansion": "tbc",
    "content_type": "raids",
    "version": "2.0.0",
    "last_updated": "2026-05-02"
  }
}
```

This allows automated tools to:
- Track which files are outdated
- Generate changelogs
- Filter by expansion
- Validate completeness

## Contributing

When contributing new NPCs, please:

1. ✅ Verify in-game that Tremor Totem removes the effect
2. ✅ Add to the correct JSON file (expansion + content type)
3. ✅ Include accurate spell IDs and names
4. ✅ Run validation before committing
5. ✅ Test the generated Lua code in-game

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.
