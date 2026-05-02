#!/usr/bin/env python3
"""
build_constructor.py - Build Plater constructor with embedded database

This script combines the Plater hooks with the generated database
to create a single constructor.lua file for distribution.
"""

import sys
from pathlib import Path


def build_constructor():
    """Build the final constructor.lua with embedded database."""
    project_dir = Path(__file__).parent.parent
    
    # Read the generated database
    db_file = project_dir / "plater" / "database_generated.lua"
    with open(db_file, 'r') as f:
        db_content = f.read()
    
    # Remove the "return {" wrapper and closing "}"
    lines = db_content.split('\n')
    # Skip header comments and "return {"
    db_lines = []
    in_table = False
    for line in lines:
        if line.strip() == "return {":
            in_table = True
            continue
        if in_table and line.strip() == "}":
            break
        if in_table:
            db_lines.append(line)
    
    db_entries = '\n'.join(db_lines)
    
    # Build the constructor
    constructor = f'''-- =============================================================================
-- CONSTRUCTOR HOOK
-- Runs once when the mod loads. Initializes configuration and NPC database.
-- =============================================================================
-- INSTALLATION: Copy this entire file into the "Constructor" hook in Plater Modding tab.
-- =============================================================================

function(self, envTable)
  -- ---------------------------------------------------------------------------
  -- CONFIGURATION
  -- ---------------------------------------------------------------------------
  
  local cfg = {{
    iconSize    = 20,
    iconTexture = "Interface\\\\Icons\\\\Spell_Nature_TremorTotem",
    xOffset     = -2,
    yOffset     = 0,
    anchorPoint = "RIGHT",
  }}
  envTable.cfg = cfg
  
  -- ---------------------------------------------------------------------------
  -- NPC DATABASE (Generated from database/*.json)
  -- ---------------------------------------------------------------------------
  
  envTable.FearDatabase = {{
{db_entries}
  }}
  
end
'''
    
    # Write the final constructor
    output_file = project_dir / "plater" / "constructor.lua"
    with open(output_file, 'w') as f:
        f.write(constructor)
    
    print(f"✓ Built constructor.lua with {len(db_lines)} database entries", file=sys.stderr)
    return output_file


if __name__ == "__main__":
    output = build_constructor()
    print(f"Output: {output}", file=sys.stderr)
