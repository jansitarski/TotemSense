# Project Structure

```
TotemSense/
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
│
└── plater/
    ├── constructor.lua             # Constructor hook - config + full NPC database
    ├── on_nameplate_added.lua      # Nameplate Added hook - icon display
    ├── on_nameplate_removed.lua    # Nameplate Removed hook - cleanup
    ├── config.lua                  # Config reference (not used in-game)
    ├── generate_import_string.py   # Builds the Plater import string
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
