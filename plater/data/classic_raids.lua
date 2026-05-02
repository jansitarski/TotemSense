-- =============================================================================
-- CLASSIC RAIDS DATABASE
-- NPCs in Classic (Vanilla) raid instances that cast Fear, Charm, or Sleep
-- effects removable by Tremor Totem.
-- =============================================================================

return {
  -- ===========================================================================
  -- MOLTEN CORE
  -- ===========================================================================

  [11673] = {
    spells   = { {id = 19408, name = "Panic", type = "fear"} },
    instance = "Molten Core",
    npc      = "Ancient Core Hound",
  },

  [11982] = {
    spells   = { {id = 19408, name = "Panic", type = "fear"} },
    instance = "Molten Core",
    npc      = "Magmadar",
  },

  -- ===========================================================================
  -- ONYXIA'S LAIR
  -- ===========================================================================

  [10184] = {
    spells   = { {id = 18431, name = "Bellowing Roar", type = "fear"} },
    instance = "Onyxia's Lair",
    npc      = "Onyxia",
  },

  -- ===========================================================================
  -- BLACKWING LAIR
  -- ===========================================================================

  [10162] = {
    spells   = { {id = 22678, name = "Fear", type = "fear"} },
    instance = "Blackwing Lair",
    npc      = "Lord Victor Nefarius",
  },

  [11583] = {
    spells   = { {id = 22686, name = "Bellowing Roar", type = "fear"} },
    instance = "Blackwing Lair",
    npc      = "Nefarian",
  },

  [12467] = {
    spells   = { {id = 15588, name = "Frightening Shout", type = "fear"} },
    instance = "Blackwing Lair",
    npc      = "Death Talon Captain",
  },

  -- ===========================================================================
  -- ZUL'GURUB
  -- ===========================================================================

  [14517] = {
    spells   = { {id = 22884, name = "Psychic Scream", type = "fear"} },
    instance = "Zul'Gurub",
    npc      = "High Priestess Jeklik",
  },

  [11352] = {
    spells   = { {id = 19134, name = "Frightening Shout", type = "fear"} },
    instance = "Zul'Gurub",
    npc      = "Gurubashi Berserker",
  },

  [11382] = {
    spells   = { {id = 19134, name = "Intimidating Shout", type = "fear"} },
    instance = "Zul'Gurub",
    npc      = "Bloodlord Mandokir",
  },

  -- ===========================================================================
  -- TEMPLE OF AHN'QIRAJ (AQ40)
  -- ===========================================================================

  [15543] = {
    spells   = { {id = 26580, name = "Fear", type = "fear"} },
    instance = "Temple of Ahn'Qiraj",
    npc      = "Princess Yauj",
  },

  [15247] = {
    spells   = { {id = 785, name = "True Fulfillment", type = "charm"} },
    instance = "Temple of Ahn'Qiraj",
    npc      = "Qiraji Brainwasher",
  },

  [15509] = {
    spells   = { {id = 26180, name = "Wyvern Sting", type = "sleep"} },
    instance = "Temple of Ahn'Qiraj",
    npc      = "Princess Huhuran",
  },

  -- ===========================================================================
  -- NAXXRAMAS
  -- ===========================================================================

  [15932] = {
    spells   = { {id = 29685, name = "Terrifying Roar", type = "fear"} },
    instance = "Naxxramas",
    npc      = "Gluth",
  },

  [15990] = {
    spells   = { {id = 28410, name = "Chains of Kel'Thuzad", type = "charm"} },
    instance = "Naxxramas",
    npc      = "Kel'Thuzad",
  },
}
