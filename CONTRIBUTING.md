# Contributing to CCPlates

## Adding a New NPC

### Before you start

1. Confirm Tremor Totem removes the effect in-game
2. Get the NPC ID and spell ID
3. Confirm the effect type: fear, charm, or sleep

Tremor Totem removes fear, charm, and sleep. It does **not** remove stun, polymorph, hex, sap, root, silence, or horror.

### Finding IDs

**NPC ID** (in-game):
```lua
/run local guid = UnitGUID("target"); if guid then print(select(6, strsplit("-", guid))) end
```
Or check the URL on `wowhead.com/tbc/npc=<search>`.

**Spell ID:** Check the NPC's abilities on Wowhead. Verify the mechanic type in combat logs or with Details!/DBM.

### Steps

1. Edit the right file in `plater/data/`:

| File | Content |
|------|---------|
| `tbc_raids.lua` | TBC raid bosses and trash |
| `tbc_dungeons.lua` | TBC dungeons (normal/heroic) |
| `classic_raids.lua` | Classic 40/20-man raids |
| `classic_dungeons.lua` | Classic 5-man dungeons |

2. Add the entry:

```lua
[12345] = {
    spells   = { {id = 67890, name = "Fear", type = "fear"} },
    instance = "Example Dungeon",
    npc      = "Example NPC",
}
```

Multiple spells:

```lua
[12345] = {
    spells = {
        {id = 111, name = "Fear", type = "fear"},
        {id = 222, name = "Mind Control", type = "charm"}
    },
    instance = "Example Raid",
    npc      = "Example Boss",
}
```

3. Add the same entry to `plater/constructor.lua` in the matching section
4. Test in-game: copy constructor to Plater or regenerate the import string, `/reload`, find the NPC

### Submitting

1. Fork, branch (`add-npc-<npcname>`), edit, test
2. Commit: `git commit -m "Add <NPC Name> to <Instance>"`
3. Push and open a PR

### Notes

- Sort entries by NPC ID within each instance section
- Match Wowhead display names
- Always update both `plater/data/*.lua` and `plater/constructor.lua`
