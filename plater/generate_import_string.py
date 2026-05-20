#!/usr/bin/env python3
"""
generate_import_string.py — Plater Nameplates import string generator for TotemSense

Reads the modular Plater hook files (constructor.lua, on_nameplate_added.lua,
on_nameplate_removed.lua), builds the Plater hook index table, and produces a
ready-to-paste import string using the same encoding pipeline Plater uses:

    Lua table → AceSerializer-3.0 → raw DEFLATE → LibDeflate EncodeForPrint

The output can be pasted directly into Plater's Import dialog or shared on wago.io.

Usage:
    python3 generate_import_string.py              # prints to stdout
    python3 generate_import_string.py > import.txt # save to file
"""

import os
import re
import sys
import time
import zlib

# ═══════════════════════════════════════════════════════════════════════════════
# LibDeflate EncodeForPrint — 6-bit encoding
# Alphabet: a-z A-Z 0-9 ( )  →  64 chars, 6 bits each
# Encodes 3 bytes → 4 chars; remainder handled with variable-length tail.
# Reference: https://github.com/SafeteeWoW/LibDeflate (EncodeForPrint)
# ═══════════════════════════════════════════════════════════════════════════════

ENCODE_6BIT = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()"


def encode_for_print(data: bytes) -> str:
    """Encode binary data using LibDeflate's EncodeForPrint 6-bit encoding."""
    result = []
    i = 0
    n = len(data)

    # Process 3 bytes → 4 encoded chars
    while i + 2 < n:
        x1, x2, x3 = data[i], data[i + 1], data[i + 2]
        i += 3
        cache = x1 + x2 * 256 + x3 * 65536
        b1 = cache % 64
        cache //= 64
        b2 = cache % 64
        cache //= 64
        b3 = cache % 64
        b4 = cache // 64
        result.append(ENCODE_6BIT[b1] + ENCODE_6BIT[b2] + ENCODE_6BIT[b3] + ENCODE_6BIT[b4])

    # Handle remaining 1–2 bytes
    cache = 0
    cache_bitlen = 0
    while i < n:
        cache += data[i] << cache_bitlen
        cache_bitlen += 8
        i += 1
    while cache_bitlen > 0:
        result.append(ENCODE_6BIT[cache % 64])
        cache >>= 6
        cache_bitlen -= 6

    return "".join(result)


# ═══════════════════════════════════════════════════════════════════════════════
# AceSerializer-3.0 — minimal compatible serializer
# Reference: https://github.com/WoWUIDev/Ace3  AceSerializer-3.0.lua
#
# Protocol format:
#   ^1          — protocol revision 1 header
#   ^S<str>     — string (escaped)
#   ^N<num>     — number (tostring)
#   ^F<m>^f<e>  — float (mantissa/exponent via frexp)
#   ^B / ^b     — boolean true / false
#   ^Z          — nil
#   ^T ... ^t   — table start / end (key-value pairs between)
#   ^^          — end of serialized data
#
# String escaping (escape char = ~ / 0x7E):
#   byte 30     → ~z (0x7E 0x7A)  — special: 30+64=94='^' collision
#   bytes 0–32  → ~ + chr(n+64)   — control chars + space
#   byte 94 '^' → ~}  (0x7E 0x7D)
#   byte 126 '~'→ ~|  (0x7E 0x7C)
#   byte 127    → ~{  (0x7E 0x7B)
# ═══════════════════════════════════════════════════════════════════════════════

# Pattern matches bytes that need escaping: 0x00-0x20, 0x5E(^), 0x7E(~), 0x7F(DEL)
_ESCAPE_RE = re.compile(r"[\x00-\x20\x5e\x7e\x7f]")


def _ace_escape_char(m) -> str:
    """Escape a single character per AceSerializer rules."""
    n = ord(m.group())
    if n == 30:
        return "\x7e\x7a"  # ~z — avoid 30+64=94='^'
    elif n <= 32:
        return "\x7e" + chr(n + 64)
    elif n == 94:  # ^
        return "\x7e\x7d"  # ~}
    elif n == 126:  # ~
        return "\x7e\x7c"  # ~|
    elif n == 127:
        return "\x7e\x7b"  # ~{
    return m.group()  # unreachable


def _ace_escape_string(s: str) -> str:
    """Escape a string for AceSerializer transport."""
    return _ESCAPE_RE.sub(_ace_escape_char, s)


def _serialize_value(value) -> str:
    """Serialize a single Lua-compatible value."""
    if value is None:
        return "^Z"
    if isinstance(value, bool):
        return "^B" if value else "^b"
    if isinstance(value, int):
        return "^N" + str(value)
    if isinstance(value, float):
        # Use integer form if exact
        if value == int(value):
            return "^N" + str(int(value))
        return "^N" + repr(value)
    if isinstance(value, str):
        return "^S" + _ace_escape_string(value)
    if isinstance(value, dict):
        parts = ["^T"]
        for k, v in value.items():
            parts.append(_serialize_value(k))
            parts.append(_serialize_value(v))
        parts.append("^t")
        return "".join(parts)
    if isinstance(value, list):
        # Serialize as 1-indexed Lua table
        parts = ["^T"]
        for i, v in enumerate(value, 1):
            parts.append(_serialize_value(i))
            parts.append(_serialize_value(v))
        parts.append("^t")
        return "".join(parts)
    raise ValueError(f"Cannot serialize type: {type(value)}")


def ace_serialize(value) -> str:
    """Serialize a value using AceSerializer-3.0 protocol."""
    return "^1" + _serialize_value(value) + "^^"


# ═══════════════════════════════════════════════════════════════════════════════
# Raw DEFLATE compression (no zlib/gzip headers — matches LibDeflate output)
# ═══════════════════════════════════════════════════════════════════════════════


def compress_deflate_raw(data: bytes) -> bytes:
    """Compress using raw DEFLATE (wbits=-15 strips zlib header/trailer)."""
    obj = zlib.compressobj(9, zlib.DEFLATED, -15)
    return obj.compress(data) + obj.flush()


# ═══════════════════════════════════════════════════════════════════════════════
# Code extraction from modular Lua files
# ═══════════════════════════════════════════════════════════════════════════════


def extract_function_body(filepath: str) -> str:
    """
    Extract the hook's Lua code from a file.

    Handles two formats:
      - Bare body (new): comment header, then the code lines directly.
      - Wrapped (legacy): comment header, then function(...)\\n<body>\\nend.

    For the wrapped format the function(...) line and the final end are stripped.
    The body's closing end is identified as the LAST non-empty line of the file,
    avoiding the truncation bug where an inner `end` was mistaken for the outer one.
    """
    with open(filepath, "r") as f:
        content = f.read()

    lines = content.split("\n")

    # Skip the leading comment/blank header block
    start = 0
    while start < len(lines) and (
        lines[start].strip() == "" or lines[start].strip().startswith("--")
    ):
        start += 1

    code_lines = lines[start:]

    # Strip function(...)...end wrapper when present
    if code_lines and code_lines[0].strip().startswith("function("):
        code_lines = code_lines[1:]          # drop the function(...) signature line
        while code_lines and code_lines[-1].strip() == "":
            code_lines.pop()                 # trim trailing blank lines
        if code_lines and code_lines[-1].strip() == "end":
            code_lines.pop()                 # drop the outer closing end

    return "\n".join(code_lines).strip("\n")


def load_hook_files(script_dir: str) -> dict:
    """
    Load all hook files and build complete function expressions for the import string.

    Plater compiles imported scripts with `loadstring("return " .. code)()`, so `code`
    must be a valid Lua expression — i.e. a complete anonymous function.  The source
    files are stored body-only (for direct pasting into Plater's script editor), so we
    wrap each body in the correct function signature here before encoding.
    Returns dict mapping Plater hook name to the full function expression string.
    """
    # (filename, Plater hook name, function signature)
    hook_specs = [
        ("constructor.lua",        "Constructor",        "function(self, unitId, unitFrame, envTable, modTable)"),
        ("on_nameplate_added.lua", "Nameplate Added",    "function(self, unitId, unitFrame, envTable, modTable)"),
        ("on_nameplate_removed.lua","Nameplate Removed", "function(self, unitId, unitFrame, envTable, modTable)"),
    ]

    hooks = {}
    for filename, hook_name, signature in hook_specs:
        filepath = os.path.join(script_dir, filename)
        if not os.path.isfile(filepath):
            raise FileNotFoundError(f"Missing required file: {filepath}")

        body = extract_function_body(filepath)
        hooks[hook_name] = f"{signature}\n{body}\nend"

    return hooks


# ═══════════════════════════════════════════════════════════════════════════════
# Build the Plater hook index table
#
# Plater export format for hooks (mods):
#   "1" = Name, "2" = Icon, "3" = Desc, "4" = Author, "5" = Time,
#   "6" = Revision, "7" = PlaterCore, "8" = LoadConditions,
#   "9" = { hookName = hookCode, ... }
#   "options" = {}, "addon" = "Plater", "type" = "hook"
#
# Reference: Plater_ImportExport.lua → PrepareTableToExport()
# ═══════════════════════════════════════════════════════════════════════════════


def build_index_table(hooks: dict) -> dict:
    """Build a Plater-compatible hook index table for export.

    Matches Plater's PrepareTableToExport() exactly:
      tableToExport["1"] = Name       (string keys, not integer keys)
      tableToExport["2"] = Icon
      tableToExport["3"] = Desc
      tableToExport["4"] = Author
      tableToExport["5"] = Time
      tableToExport["6"] = Revision
      tableToExport["7"] = PlaterCore
      tableToExport["8"] = LoadConditions
      tableToExport["9"] = { hookName = code, ... }
      tableToExport["UID"] = unique id
      tableToExport["options"] = {}
      tableToExport["addon"] = "Plater"
      tableToExport["tocversion"] = build info
      tableToExport["type"] = "hook"
    """
    ts = int(time.time())
    return {
        "1": "TotemSense",
        "2": "Interface\\Icons\\Spell_Nature_TremorTotem",
        "3": "Shows Tremor Totem icon on nameplates of NPCs that cast Fear, Charm, or Sleep",
        "4": "TotemSense",
        "5": ts,
        "6": 1,           # Revision
        "7": 1,           # PlaterCore minimum version
        "8": {            # LoadConditions — all 10 sub-fields required by Plater
            "class": {},
            "spec": {},
            "race": {},
            "talent": {},
            "pvptalent": {},
            "group": {},
            "role": {},
            "affix": {},
            "encounter_ids": {},
            "map_ids": {},
        },
        "9": hooks,       # { "Constructor": "...", "Nameplate Added": "...", ... }
        "UID": ts,        # unique identifier
        "options": {},
        "addon": "Plater",
        "tocversion": "2.5.5",
        "type": "hook",
    }


# ═══════════════════════════════════════════════════════════════════════════════
# Full pipeline: table → AceSerializer → DEFLATE → EncodeForPrint
# ═══════════════════════════════════════════════════════════════════════════════


def generate_import_string(index_table: dict) -> str:
    """Generate a Plater import string from an index table."""
    serialized = ace_serialize(index_table)
    compressed = compress_deflate_raw(serialized.encode("utf-8"))
    encoded = encode_for_print(compressed)
    return encoded


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    try:
        # Load hook code from modular files
        hooks = load_hook_files(script_dir)
    except FileNotFoundError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    # Build index table and generate import string
    index_table = build_index_table(hooks)
    import_string = generate_import_string(index_table)

    print(import_string)


if __name__ == "__main__":
    main()
