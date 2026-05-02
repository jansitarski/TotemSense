# CCPlates - Crowd Control Nameplate Tracker

A multi-platform nameplate mod for WoW TBC Classic that displays visual indicators on nameplates of NPCs that cast Fear, Charm, or Sleep effects. Works with Plater Nameplates, WeakAuras, and as a standalone addon.

**Default Icon Theme**: Tremor Totem (Shaman utility) - displays when NPCs cast crowd control effects that Tremor Totem can remove.

## Features

- 🎯 **Smart Detection**: Automatically shows Tremor Totem icon on nameplates of NPCs with Fear/Charm/Sleep abilities
- 📊 **Comprehensive Database**: Covers all Classic and TBC raid/dungeon encounters
- ⚙️ **Customizable**: Easy-to-configure icon size, position, and appearance
- 🚀 **Performance-Optimized**: Lightweight and efficient nameplate handling
- 🔄 **Plater-Native**: Built specifically for Plater Nameplates (no addon required)

## Installation

### Prerequisites
- **Plater Nameplates** addon installed and enabled
- WoW TBC Classic Anniversary (Interface 20505)
- **Python 3** (to generate the import string)

### Installation Steps

#### 1. Generate the Import String

Navigate to the `plater/` directory and run:
```bash
python3 generate_import_string.py
```

Copy the entire output (it will be a long encoded string).

#### 2. Import into Plater

1. In-game, type `/plater`
2. Navigate to the **Modding** tab
3. Click **Import Mod** (or **Import**)
4. Paste the import string from step 1
5. Click **OK** or **Import**

The mod will be automatically installed with all three hooks configured!

#### 3. Enable and Test

1. In the **Modding** tab, check the **Enable** checkbox for CCPlates
2. Click **Save** or **Apply**
3. Type `/reload` to reload your UI
4. Done! Tremor Totem icons will now appear on relevant nameplates

## Customization

Edit the configuration in the **Constructor** section (`plater/constructor.lua`):

```lua
local cfg = {
    iconSize   = 20,      -- Icon width/height in pixels
    iconTexture = "Interface\\Icons\\Spell_Nature_TremorTotem",
    xOffset    = -2,      -- Horizontal offset (negative = left)
    yOffset    = 0,       -- Vertical offset
}
```

### Custom Icon Options
You can change the icon to any game texture:
- `"Interface\\Icons\\Spell_Nature_TremorTotem"` (default)
- `"Interface\\Icons\\Spell_Shaman_ImprovedReincarnation"` (glowing totem)
- Any other interface path from WoW's textures

## Database Structure

The NPC database is organized by expansion and content type:

```
plater/
├── data/
│   ├── tbc_raids.lua      # TBC raid bosses and trash
│   ├── tbc_dungeons.lua   # TBC dungeon encounters
│   ├── classic_raids.lua  # Classic raid content
│   └── classic_dungeons.lua # Classic dungeon content
```

Each entry includes:
- **NPC ID**: Unique creature identifier
- **Spell Data**: All Fear/Charm/Sleep abilities
- **Instance Name**: Where the NPC is found
- **NPC Name**: Display name

### Example Entry
```lua
[17521] = {
    spells   = { {id = 30752, name = "Terrifying Howl", type = "fear"} },
    instance = "Karazhan",
    npc      = "The Big Bad Wolf",
}
```

## Coverage

### TBC Raids
- Karazhan
- Gruul's Lair
- Magtheridon's Lair
- Serpentshrine Cavern
- Tempest Keep: The Eye
- Hyjal Summit
- Black Temple
- Zul'Aman

### TBC Dungeons
- Hellfire Citadel (all wings)
- Coilfang Reservoir (all wings)
- Auchindoun (all wings)
- Tempest Keep dungeons
- Caverns of Time dungeons
- Magisters' Terrace

### Classic Raids
- Molten Core
- Onyxia's Lair
- Blackwing Lair
- Zul'Gurub
- Temple of Ahn'Qiraj
- Naxxramas

### Classic Dungeons
- All level 60 dungeons (Scholomance, Stratholme, UBRS, LBRS, BRD, etc.)
- Mid-level dungeons with fear effects

## How It Works

1. **Nameplate Detection**: When a nameplate appears, the mod checks the unit's NPC ID
2. **Database Lookup**: Searches the comprehensive NPC database for matching entries
3. **Icon Display**: If found, displays a Tremor Totem icon overlay on the nameplate
4. **Cleanup**: Removes the icon when the nameplate disappears

## Performance

- **Zero Combat Impact**: No protected functions - safe during combat
- **Efficient Lookups**: O(1) hash table lookups for NPC data
- **Frame Recycling**: Properly handles Plater's nameplate recycling
- **Minimal Memory**: Lightweight database structure

## Troubleshooting

**Icons not showing up?**
- Ensure Plater Nameplates is enabled
- Check that enemy nameplates are visible (`V` key by default)
- Verify the mod is enabled in Plater's Modding tab
- Make sure you're targeting hostile NPCs (not friendly units)

**Icons persist after nameplate disappears?**
- This shouldn't happen with proper frame recycling
- Try `/reload` to reset

**Performance issues?**
- Reduce `iconSize` in the configuration
- The mod is optimized and should have negligible impact

## Contributing

To add new NPCs to the database:

1. Find the NPC ID using `/tar <npc name>` and examining the GUID, or use Wowhead
2. Identify the spell ID and type (fear/charm/sleep)
3. Add an entry to the appropriate data file in `plater/data/`
4. Verify Tremor Totem actually removes the effect in-game

## Credits

- Database compiled from Wowhead, Icy Veins, and community raid guides
- Built for Shamans by a dedicated Shaman main
