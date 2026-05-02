# Import String Generator

Generates a Plater import string from the three Lua hook files. One paste into Plater instead of copying three files by hand.

## Usage

```bash
cd plater
python3 generate_import_string.py > import_string.txt
```

Regenerate whenever you change any hook file, add NPCs, or update config defaults.

## Technical details

The script implements Plater's export format:
- **AceSerializer-3.0**: Lua table serialization
- **LibDeflate**: Raw DEFLATE compression
- **EncodeForPrint**: 6-bit encoding (a-z, A-Z, 0-9, (), )
