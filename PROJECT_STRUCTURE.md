# Project Structure

```
TremorAlert/
├── README.md                       # Main documentation and overview
├── QUICKSTART.md                   # 5-minute installation guide
├── CHANGELOG.md                    # Version history and changes
├── CONTRIBUTING.md                 # Guide for adding new NPCs
│
└── plater/                         # Plater Nameplates mod files
    ├── constructor.lua             # [MAIN] Constructor hook - initialization & database
    ├── on_nameplate_added.lua      # Nameplate Added hook - icon display logic
    ├── on_nameplate_removed.lua    # Nameplate Removed hook - cleanup
    ├── config.lua                  # Configuration reference (not used in-game)
    │
    └── data/                       # Modular database files (reference only)
        ├── tbc_raids.lua           # TBC raid NPCs
        ├── tbc_dungeons.lua        # TBC dungeon NPCs
        ├── classic_raids.lua       # Classic raid NPCs
        ├── classic_dungeons.lua    # Classic dungeon NPCs
        └── loader.lua              # Database merging logic
```

## File Purposes

### Root Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Comprehensive documentation, features, and coverage details |
| `QUICKSTART.md` | Fast installation guide for new users |
| `CHANGELOG.md` | Version history and release notes |
| `CONTRIBUTING.md` | Instructions for adding new NPCs to database |

### Plater Mod Files (Required for In-Game Use)

| File | Hook | Description |
|------|------|-------------|
| `plater/constructor.lua` | Constructor | **[COPY TO PLATER]** Initialization script with full database |
| `plater/on_nameplate_added.lua` | Nameplate Added | **[COPY TO PLATER]** Icon display logic |
| `plater/on_nameplate_removed.lua` | Nameplate Removed | **[COPY TO PLATER]** Icon cleanup |

### Reference Files (Development Only)

| File | Purpose |
|------|---------|
| `plater/config.lua` | Configuration example (edit in constructor.lua instead) |
| `plater/data/*.lua` | Modular database files (merged into constructor.lua) |
| `plater/data/loader.lua` | Database merging logic |

## How It Works

### Installation Flow
1. User copies `constructor.lua` → Plater Constructor hook
2. User copies `on_nameplate_added.lua` → Plater Nameplate Added hook
3. User copies `on_nameplate_removed.lua` → Plater Nameplate Removed hook
4. User enables the mod and reloads UI

### Runtime Flow
1. **Constructor** runs once on mod load, initializing config and NPC database
2. **Nameplate Added** runs when a nameplate appears, checking database and showing icon if matched
3. **Nameplate Removed** runs when a nameplate disappears, hiding the icon

### Database Organization

The NPC database is organized logically by expansion and content type:

- **TBC Raids**: Karazhan, Gruul's, Magtheridon, SSC, TK, Hyjal, BT, ZA
- **TBC Dungeons**: All Hellfire, Coilfang, Auchindoun, TK, and CoT dungeons
- **Classic Raids**: MC, Onyxia, BWL, ZG, AQ40, Naxxramas
- **Classic Dungeons**: All level 60 dungeons and notable mid-level dungeons

Each entry includes:
- NPC ID (key)
- Spell(s) with ID, name, and type
- Instance name
- NPC name

## Development vs Production

### Development (This Repository)
- Modular database files in `plater/data/` for easy maintenance
- Separate configuration in `plater/config.lua`
- Clear file organization

### Production (In-Game)
- Single `constructor.lua` file with all databases merged
- Configuration embedded in constructor
- Three total files to copy into Plater

## Adding New NPCs

To add a new NPC:

1. **Development**: Edit the appropriate `plater/data/*.lua` file
2. **Production**: Also add the entry to `plater/constructor.lua` in the matching section
3. Test in-game by copying updated `constructor.lua` to Plater

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed instructions.

## File Sizes (Approximate)

- `constructor.lua`: ~8 KB (contains full database)
- `on_nameplate_added.lua`: ~1 KB
- `on_nameplate_removed.lua`: ~0.3 KB
- **Total in-game footprint**: ~9 KB

The database is loaded once on mod initialization and uses O(1) hash table lookups for optimal performance.
