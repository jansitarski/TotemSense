# Quick Start Guide

Get TremorAlert running in 5 minutes!

## Step 1: Prerequisites
- Install **Plater Nameplates** addon from CurseForge or WoW Interface
- Enable Plater in-game: `/plater`

## Step 2: Prerequisites Check
- Python 3 installed (to run the import string generator)
- Git or downloaded repository files

## Step 3: Generate the Import String

1. Navigate to the `plater/` directory in this repository
2. Run the import string generator:
   ```bash
   python3 generate_import_string.py
   ```
3. Copy the entire output (it will be a long encoded string)

## Step 4: Import into Plater

1. In-game, type `/plater`
2. Navigate to the **Modding** tab
3. Click **Import Mod** (or **Import**)
4. Paste the import string from Step 3
5. Click **OK** or **Import**

The mod will be automatically installed with all three hooks configured!

## Step 5: Enable and Test

1. In the Plater **Modding** tab, check the **Enable** checkbox for TremorAlert
2. Click **Save** or **Apply**
3. Type `/reload` to reload your UI

### Test It!
1. Go to any dungeon or raid with Fear/Charm/Sleep mobs
2. Target a mob from the database (e.g., Spectral Charger in Karazhan)
3. You should see a Tremor Totem icon on the nameplate!

## Troubleshooting

**Icons not appearing?**
- Make sure enemy nameplates are visible (press `V`)
- Verify the mod is enabled in Plater Modding tab
- Try `/reload` to restart

**Performance issues?**
- Reduce icon size in the Constructor config (line 12)
- The mod is already optimized and should have minimal impact

## Customization

To change icon size or position, edit these lines in the **Constructor hook**:

```lua
local cfg = {
  iconSize    = 20,      -- Change this number (pixels)
  xOffset     = -2,      -- Horizontal offset (negative = left)
  yOffset     = 0,       -- Vertical offset
}
```

After making changes, click **Save** and `/reload`.

## Need Help?

- Read the full [README.md](README.md) for detailed documentation
- Check [CONTRIBUTING.md](CONTRIBUTING.md) to add new NPCs
- Review the database files in `plater/data/` to see what's covered

Happy totem dropping! 🔱
