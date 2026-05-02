# Import String Generator

This directory contains a Python script that automatically generates a Plater import string from the modular Lua files.

## What is this for?

The import string allows users to install CCPlates with a single copy-paste into Plater's Import dialog, instead of manually copying three separate files into three different hooks.

## Usage

```bash
cd plater
python3 generate_import_string.py > import_string.txt
```

This will:
1. Read `constructor.lua`, `on_nameplate_added.lua`, and `on_nameplate_removed.lua`
2. Extract the function bodies from each file
3. Build a Plater-compatible hook index table
4. Serialize, compress, and encode the data using Plater's format
5. Output the import string to `import_string.txt`

## How to use the import string

1. Copy the entire contents of `import_string.txt`
2. In-game, type `/plater`
3. Go to the **Import** tab
4. Paste the import string
5. Click **Import**
6. Done! CCPlates is now installed

## Technical details

The script implements Plater's export format:
- **AceSerializer-3.0**: Lua table serialization protocol
- **LibDeflate**: Raw DEFLATE compression
- **EncodeForPrint**: 6-bit encoding (a-z, A-Z, 0-9, (), )

This matches the exact encoding pipeline that Plater uses for mod exports.

## When to regenerate

Regenerate the import string whenever you:
- Update any of the three hook files
- Add new NPCs to the database in `constructor.lua`
- Change configuration defaults
- Release a new version

## Distribution

The `import_string.txt` can be:
- Shared directly with users
- Uploaded to wago.io
- Included in GitHub releases
- Posted on Discord/forums

Users can import it without needing to manually copy-paste code into Plater hooks.
