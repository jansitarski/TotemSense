# Contributing to CCPlates

Thank you for your interest in improving CCPlates! This guide will help you add new NPCs to the database.

## Database Structure

CCPlates uses a **JSON source of truth** for the NPC database, which can be compiled into different formats (Plater, addon, WeakAura).

**Source files:** `database/*.json`  
**Generated files:** `plater/constructor.lua`, `addon_generated/Database.lua`, `weakaura_generated/database.lua`

## Adding New NPCs

### Prerequisites
1. Verify that Tremor Totem actually removes the effect in-game
2. Identify the NPC ID and spell ID
3. Confirm the effect type (fear, charm, or sleep)

### Finding NPC and Spell IDs

#### NPC ID
1. **In-game method**: Target the NPC and type:
   ```lua
   /run local guid = UnitGUID("target"); if guid then print(select(6, strsplit("-", guid))) end
   ```
2. **Wowhead method**: Visit `wowhead.com/tbc/npc=<search>` and find the NPC ID in the URL

#### Spell ID
1. Check Wowhead for the NPC's abilities: `wowhead.com/tbc/npc=<npcid>`
2. Look at the spell details to confirm the mechanic type
3. Verify on combat log or with addons like Details! or DBM

### Effect Types

Tremor Totem removes these mechanics:
- **fear**: Fear effects (most common)
- **charm**: Mind Control / Charm effects
- **sleep**: Sleep effects (e.g., Wyvern Sting, Druid's Slumber)

Tremor Totem does **NOT** remove:
- Stun, Polymorph, Hex, Sap, Root, Silence, Horror

### Step-by-Step Guide

#### Step 1: Edit JSON File

Choose the appropriate file based on expansion and content type:

| File | Content |
|------|---------|
| `database/tbc_raids.json` | TBC raid bosses and trash |
| `database/tbc_dungeons.json` | TBC dungeons (normal/heroic) |
| `database/classic_raids.json` | Classic 40/20-man raids |
| `database/classic_dungeons.json` | Classic 5-man dungeons |

#### Step 2: Add JSON Entry

Edit the appropriate JSON file and add your entry to the `npcs` object:

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

#### Step 3: Validate JSON

```bash
python3 database/generate_database.py --format json
```

This will check for syntax errors and show updated statistics.

#### Step 4: Generate Lua Files

```bash
# Generate Plater database
python3 database/generate_database.py --format plater

# Build final constructor
python3 database/build_constructor.py

# Regenerate import string
cd plater && python3 generate_import_string.py > import_string.txt
```

#### Step 5: Test In-Game

1. Copy updated `plater/constructor.lua` to Plater Constructor hook
2. `/reload` in-game
3. Find the NPC and verify the icon appears
4. Confirm Tremor Totem removes the effect

### Submitting Changes

If you're contributing to the project:
1. Fork the repository
2. Create a feature branch: `git checkout -b add-npc-<npcname>`
3. Edit the appropriate JSON file in `database/`
4. Run validation and generation scripts (see Step 3-4 above)
5. Commit with a clear message: `git commit -m "Add <NPC Name> to <Instance>"`
6. Push and create a Pull Request

**Important:** Only commit the JSON source files. Generated Lua files will be rebuilt automatically.

### Example: Adding a New NPC

Let's add a fictional TBC dungeon mob:

**NPC Details:**
- Name: Void Reaver Helper
- NPC ID: 12345
- Instance: The Mechanar
- Spell: Psychic Scream (ID: 13704)
- Type: fear

**1. Edit `database/tbc_dungeons.json`:**

```json
{
  "npcs": {
    "12345": {
      "npc": "Void Reaver Helper",
      "instance": "The Mechanar",
      "spells": [
        {"id": 13704, "name": "Psychic Scream", "type": "fear"}
      ]
    }
  }
}
```

**2. Validate:**

```bash
python3 database/generate_database.py --format json
# Should show: ✓ Loaded tbc_dungeons.json: 23 NPCs (was 22)
```

**3. Generate and test:**

```bash
python3 database/generate_database.py --format plater
python3 database/build_constructor.py
# Copy plater/constructor.lua to Plater in-game and test
```

### Maintenance Notes

- Keep entries sorted by NPC ID within each instance section (JSON doesn't require order, but it helps readability)
- Use consistent naming (match Wowhead display names)
- The JSON source is the single source of truth - edit JSON first, then generate Lua
- Generated Lua files are automatically created from JSON - don't edit them manually

## Questions?

If you're unsure about an entry or need help:
- Check existing similar entries as examples
- Verify the mechanic type on Wowhead
- Test with Tremor Totem in-game to be certain

Thank you for contributing! 🎉
