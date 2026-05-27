# Project Structure

```
TotemSense/
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
├── PROJECT_STRUCTURE.md
│
├── .github/
│   ├── totemsense-collage.png
│   └── workflows/release.yml       # Tag-triggered GitHub Release with import string
│
├── database/                       # Source-of-truth NPC data (JSON) + generators
│   ├── classic_dungeons.json
│   ├── classic_raids.json
│   ├── tbc_dungeons.json
│   ├── tbc_raids.json
│   ├── generate_database.py        # JSON -> plater/data/*.lua
│   └── build_constructor.py        # Merges data into plater/constructor.lua
│
└── plater/
    ├── constructor.lua             # Constructor hook - config + full NPC database
    ├── on_nameplate_added.lua      # Nameplate Added hook - icon display
    ├── on_nameplate_removed.lua    # Nameplate Removed hook - cleanup
    ├── config.lua                  # Config reference (not used in-game)
    ├── generate_import_string.py   # Builds the Plater import string
    ├── import_string.txt           # Pre-built import string (latest release)
    ├── IMPORT_STRING.md
    │
    └── data/                       # Modular database files (reference/development)
        ├── tbc_raids.lua
        ├── tbc_dungeons.lua
        ├── classic_raids.lua
        ├── classic_dungeons.lua
        └── loader.lua              # Merges data files into constructor
```

## Development vs Production

**Development:** Modular files in `plater/data/` for easier editing. Config in `plater/config.lua`.

**Production (in-game):** Single `constructor.lua` with all databases merged. Three files total go into Plater hooks. Use the import string generator to bundle them.
