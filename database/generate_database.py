#!/usr/bin/env python3
"""
generate_database.py - Generate Lua database tables from JSON source files

This script reads the JSON database files and generates Lua table code
that can be used in different implementations (Plater, addon, WeakAura).

Usage:
    python3 generate_database.py                    # Generate all formats
    python3 generate_database.py --format plater    # Generate Plater format only
    python3 generate_database.py --format addon     # Generate addon format only
    python3 generate_database.py --format json      # Just validate JSON files
"""

import json
import os
import sys
from pathlib import Path
from typing import Dict, List, Any


class DatabaseGenerator:
    def __init__(self, database_dir: str):
        self.database_dir = Path(database_dir)
        self.data = {}
        
    def load_json_files(self) -> Dict[str, Any]:
        """Load all JSON database files."""
        json_files = list(self.database_dir.glob("*.json"))
        
        if not json_files:
            raise FileNotFoundError(f"No JSON files found in {self.database_dir}")
        
        data = {}
        for json_file in json_files:
            with open(json_file, 'r') as f:
                content = json.load(f)
                key = json_file.stem  # filename without extension
                data[key] = content
                print(f"✓ Loaded {json_file.name}: {len(content['npcs'])} NPCs", file=sys.stderr)
        
        return data
    
    def generate_plater_lua(self, data: Dict[str, Any]) -> str:
        """Generate Lua code for Plater mod (inline table format)."""
        lines = []
        
        # Generate separate tables for each category
        for category, content in sorted(data.items()):
            expansion = content['metadata']['expansion']
            content_type = content['metadata']['content_type']
            
            lines.append(f"  -- {expansion.upper()} {content_type.upper()}")
            
            for npc_id, npc_data in content['npcs'].items():
                # Build spells array
                spells = []
                for spell in npc_data['spells']:
                    spell_str = f"{{id={spell['id']}, name=\"{spell['name']}\", type=\"{spell['type']}\"}}"
                    spells.append(spell_str)
                spells_str = ", ".join(spells)
                
                # Generate compact inline format
                lines.append(
                    f"  [{npc_id}] = {{ spells = {{{spells_str}}}, "
                    f"instance=\"{npc_data['instance']}\", npc=\"{npc_data['npc']}\" }},"
                )
            
            lines.append("")  # Blank line between sections
        
        return "\n".join(lines)
    
    def generate_addon_lua(self, data: Dict[str, Any]) -> str:
        """Generate Lua code for standalone addon (return table format)."""
        lines = []
        lines.append("-- Generated from database/*.json")
        lines.append("-- Do not edit manually - use generate_database.py")
        lines.append("")
        lines.append("return {")
        
        for category, content in sorted(data.items()):
            expansion = content['metadata']['expansion']
            content_type = content['metadata']['content_type']
            
            lines.append(f"  -- {expansion.upper()} {content_type.upper()}")
            
            for npc_id, npc_data in content['npcs'].items():
                lines.append(f"  [{npc_id}] = {{")
                
                # Spells array
                lines.append("    spells = {")
                for spell in npc_data['spells']:
                    lines.append(
                        f"      {{id = {spell['id']}, name = \"{spell['name']}\", type = \"{spell['type']}\"}},")
                lines.append("    },")
                
                # Other fields
                lines.append(f"    instance = \"{npc_data['instance']}\",")
                lines.append(f"    npc = \"{npc_data['npc']}\",")
                lines.append("  },")
                lines.append("")
            
        lines.append("}")
        return "\n".join(lines)
    
    def generate_weakaura_lua(self, data: Dict[str, Any]) -> str:
        """Generate Lua code for WeakAura (aura_env format)."""
        lines = []
        lines.append("-- Generated database for WeakAura")
        lines.append("aura_env.npcDatabase = {")
        
        for category, content in sorted(data.items()):
            for npc_id, npc_data in content['npcs'].items():
                spells = []
                for spell in npc_data['spells']:
                    spell_str = f"{{id={spell['id']},name=\"{spell['name']}\",type=\"{spell['type']}\"}}"
                    spells.append(spell_str)
                spells_str = ",".join(spells)
                
                lines.append(
                    f"  [{npc_id}]={{spells={{{spells_str}}},instance=\"{npc_data['instance']}\",npc=\"{npc_data['npc']}\"}},"
                )
        
        lines.append("}")
        return "\n".join(lines)
    
    def validate_database(self, data: Dict[str, Any]) -> bool:
        """Validate database structure and report statistics."""
        print("\n=== Database Validation ===", file=sys.stderr)
        
        total_npcs = 0
        by_type = {"fear": 0, "charm": 0, "sleep": 0}
        by_expansion = {"classic": 0, "tbc": 0}
        
        for category, content in data.items():
            expansion = content['metadata']['expansion']
            npcs = content['npcs']
            total_npcs += len(npcs)
            by_expansion[expansion] = by_expansion.get(expansion, 0) + len(npcs)
            
            for npc_id, npc_data in npcs.items():
                for spell in npc_data['spells']:
                    spell_type = spell['type']
                    if spell_type in by_type:
                        by_type[spell_type] += 1
        
        print(f"Total NPCs: {total_npcs}", file=sys.stderr)
        print(f"  Classic: {by_expansion['classic']}", file=sys.stderr)
        print(f"  TBC: {by_expansion['tbc']}", file=sys.stderr)
        print(f"Spell Types:", file=sys.stderr)
        print(f"  Fear: {by_type['fear']}", file=sys.stderr)
        print(f"  Charm: {by_type['charm']}", file=sys.stderr)
        print(f"  Sleep: {by_type['sleep']}", file=sys.stderr)
        print(f"✓ Validation passed", file=sys.stderr)
        
        return True


def main():
    import argparse
    
    parser = argparse.ArgumentParser(description="Generate Lua database from JSON sources")
    parser.add_argument(
        "--format",
        choices=["plater", "addon", "weakaura", "json"],
        default="all",
        help="Output format (default: all)"
    )
    parser.add_argument(
        "--output-dir",
        default=None,
        help="Output directory (default: varies by format)"
    )
    
    args = parser.parse_args()
    
    # Determine paths
    script_dir = Path(__file__).parent
    project_dir = script_dir.parent
    database_dir = project_dir / "database"
    
    if not database_dir.exists():
        print(f"Error: Database directory not found: {database_dir}", file=sys.stderr)
        sys.exit(1)
    
    # Load and validate database
    generator = DatabaseGenerator(database_dir)
    data = generator.load_json_files()
    generator.validate_database(data)
    
    # Generate output
    if args.format == "json":
        print("\n✓ JSON validation complete", file=sys.stderr)
        return
    
    print(f"\n=== Generating {args.format} format ===", file=sys.stderr)
    
    if args.format in ["plater", "all"]:
        lua_code = generator.generate_plater_lua(data)
        output_file = project_dir / "plater" / "database_generated.lua"
        with open(output_file, 'w') as f:
            f.write("-- GENERATED FILE - DO NOT EDIT\n")
            f.write("-- Source: database/*.json\n")
            f.write("-- Generator: database/generate_database.py\n\n")
            f.write("return {\n")
            f.write(lua_code)
            f.write("}\n")
        print(f"✓ Generated Plater database: {output_file}", file=sys.stderr)
    
    if args.format in ["addon", "all"]:
        lua_code = generator.generate_addon_lua(data)
        output_file = project_dir / "addon_generated" / "Database.lua"
        output_file.parent.mkdir(exist_ok=True)
        with open(output_file, 'w') as f:
            f.write(lua_code)
        print(f"✓ Generated addon database: {output_file}", file=sys.stderr)
    
    if args.format in ["weakaura", "all"]:
        lua_code = generator.generate_weakaura_lua(data)
        output_file = project_dir / "weakaura_generated" / "database.lua"
        output_file.parent.mkdir(exist_ok=True)
        with open(output_file, 'w') as f:
            f.write(lua_code)
        print(f"✓ Generated WeakAura database: {output_file}", file=sys.stderr)
    
    print("\n✓ Database generation complete!", file=sys.stderr)


if __name__ == "__main__":
    main()
