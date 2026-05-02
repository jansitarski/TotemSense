-- =============================================================================
-- TBC RAIDS DATABASE
-- NPCs in TBC raid instances that cast Fear, Charm, or Sleep effects
-- removable by Tremor Totem.
-- =============================================================================

return {
  -- ===========================================================================
  -- KARAZHAN (Instance 532)
  -- ===========================================================================

  [15547] = {
    spells   = { {id = 29321, name = "Fear", type = "fear"} },
    instance = "Karazhan",
    npc      = "Spectral Charger",
  },

  [15548] = {
    spells   = { {id = 29321, name = "Fear", type = "fear"} },
    instance = "Karazhan",
    npc      = "Spectral Stallion",
  },

  [17521] = {
    spells   = { {id = 30752, name = "Terrifying Howl", type = "fear"} },
    instance = "Karazhan",
    npc      = "The Big Bad Wolf",
  },

  [17225] = {
    spells   = { {id = 36922, name = "Bellowing Roar", type = "fear"} },
    instance = "Karazhan",
    npc      = "Nightbane",
  },

  -- ===========================================================================
  -- GRUUL'S LAIR (Instance 565)
  -- ===========================================================================

  [18831] = {
    spells   = { {id = 16508, name = "Intimidating Roar", type = "fear"} },
    instance = "Gruul's Lair",
    npc      = "High King Maulgar",
  },

  -- ===========================================================================
  -- MAGTHERIDON'S LAIR (Instance 544)
  -- ===========================================================================

  [17256] = {
    spells   = { {id = 30530, name = "Fear", type = "fear"} },
    instance = "Magtheridon's Lair",
    npc      = "Hellfire Channeler",
  },

  [18829] = {
    spells   = { {id = 30530, name = "Fear", type = "fear"} },
    instance = "Magtheridon's Lair",
    npc      = "Hellfire Warder",
  },

  -- ===========================================================================
  -- SERPENTSHRINE CAVERN (Instance 548)
  -- ===========================================================================

  [21215] = {
    spells   = { {id = 37749, name = "Madness", type = "charm"} },
    instance = "Serpentshrine Cavern",
    npc      = "Leotheras the Blind",
  },

  [22056] = {
    spells   = { {id = 38154, name = "Panic", type = "fear"} },
    instance = "Serpentshrine Cavern",
    npc      = "Coilfang Strider",
  },

  -- ===========================================================================
  -- TEMPEST KEEP: THE EYE (Instance 550)
  -- ===========================================================================

  [19622] = {
    spells   = {
      {id = 44863, name = "Fear",         type = "fear"},
      {id = 36797, name = "Mind Control", type = "charm"},
    },
    instance = "Tempest Keep",
    npc      = "Kael'thas Sunstrider",
  },

  -- ===========================================================================
  -- HYJAL SUMMIT (Instance 534)
  -- ===========================================================================

  [17808] = {
    spells   = { {id = 31298, name = "Sleep", type = "sleep"} },
    instance = "Hyjal Summit",
    npc      = "Anetheron",
  },

  [17968] = {
    spells   = { {id = 31970, name = "Fear", type = "fear"} },
    instance = "Hyjal Summit",
    npc      = "Archimonde",
  },

  -- ===========================================================================
  -- BLACK TEMPLE (Instance 564)
  -- ===========================================================================

  [22847] = {
    spells   = { {id = 19386, name = "Wyvern Sting", type = "sleep"} },
    instance = "Black Temple",
    npc      = "Ashtongue Primalist",
  },

  -- ===========================================================================
  -- ZUL'AMAN (Instance 568)
  -- ===========================================================================

  [23576] = {
    spells   = { {id = 42398, name = "Frightening Roar", type = "fear"} },
    instance = "Zul'Aman",
    npc      = "Nalorakk",
  },
}
