-- =============================================================================
-- CLASSIC DUNGEONS DATABASE
-- NPCs in Classic dungeons that cast Fear, Charm, or Sleep effects.
-- Default icon: Tremor Totem (removable by Tremor Totem).
-- =============================================================================

return {
  -- ===========================================================================
  -- WAILING CAVERNS
  -- ===========================================================================

  [3671] = {
    spells   = { {id = 8040, name = "Druid's Slumber", type = "sleep"} },
    instance = "Wailing Caverns",
    npc      = "Lady Anacondra",
  },

  [3669] = {
    spells   = { {id = 8040, name = "Druid's Slumber", type = "sleep"} },
    instance = "Wailing Caverns",
    npc      = "Lord Cobrahn",
  },

  [3670] = {
    spells   = { {id = 8040, name = "Druid's Slumber", type = "sleep"} },
    instance = "Wailing Caverns",
    npc      = "Lord Pythas",
  },

  [3673] = {
    spells   = { {id = 8040, name = "Druid's Slumber", type = "sleep"} },
    instance = "Wailing Caverns",
    npc      = "Lord Serpentis",
  },

  [3840] = {
    spells   = { {id = 8040, name = "Druid's Slumber", type = "sleep"} },
    instance = "Wailing Caverns",
    npc      = "Druid of the Fang",
  },

  -- ===========================================================================
  -- SHADOWFANG KEEP
  -- ===========================================================================

  [2529] = {
    spells   = { {id = 7399, name = "Terrify", type = "fear"} },
    instance = "Shadowfang Keep",
    npc      = "Son of Arugal",
  },

  [3872] = {
    spells   = { {id = 7399, name = "Terrify", type = "fear"} },
    instance = "Shadowfang Keep",
    npc      = "Deathsworn Captain",
  },

  -- ===========================================================================
  -- RAZORFEN KRAUL
  -- ===========================================================================

  [4518] = {
    spells   = { {id = 12542, name = "Fear", type = "fear"} },
    instance = "Razorfen Kraul",
    npc      = "Death's Head Sage",
  },

  -- ===========================================================================
  -- SCARLET MONASTERY
  -- ===========================================================================

  [6490] = {
    spells   = { {id = 7399, name = "Terrify", type = "fear"} },
    instance = "Scarlet Monastery",
    npc      = "Azshir the Sleepless",
  },

  [3977] = {
    spells   = {
      {id = 9256,  name = "Deep Sleep",    type = "sleep"},
      {id = 14515, name = "Dominate Mind", type = "charm"},
    },
    instance = "Scarlet Monastery",
    npc      = "High Inquisitor Whitemane",
  },

  -- ===========================================================================
  -- SUNKEN TEMPLE (TEMPLE OF ATAL'HAKKAR)
  -- ===========================================================================

  [5271] = {
    spells   = { {id = 12542, name = "Fear", type = "fear"} },
    instance = "Sunken Temple",
    npc      = "Atal'ai Deathwalker",
  },

  -- ===========================================================================
  -- BLACKROCK DEPTHS
  -- ===========================================================================

  [8895] = {
    spells   = { {id = 5246, name = "Intimidating Shout", type = "fear"} },
    instance = "Blackrock Depths",
    npc      = "Anvilrage Officer",
  },

  -- ===========================================================================
  -- LOWER BLACKROCK SPIRE
  -- ===========================================================================

  [9218] = {
    spells   = { {id = 19134, name = "Frightening Shout", type = "fear"} },
    instance = "Lower Blackrock Spire",
    npc      = "Spirestone Battle Lord",
  },

  [9217] = {
    spells   = { {id = 12542, name = "Fear", type = "fear"} },
    instance = "Lower Blackrock Spire",
    npc      = "Spirestone Lord Magus",
  },

  -- ===========================================================================
  -- UPPER BLACKROCK SPIRE
  -- ===========================================================================

  [10430] = {
    spells   = { {id = 14100, name = "Terrifying Roar", type = "fear"} },
    instance = "Upper Blackrock Spire",
    npc      = "The Beast",
  },

  -- ===========================================================================
  -- DIRE MAUL
  -- ===========================================================================

  [11445] = {
    spells   = { {id = 12542, name = "Fear", type = "fear"} },
    instance = "Dire Maul",
    npc      = "Gordok Captain",
  },

  [11448] = {
    spells   = { {id = 12542, name = "Fear", type = "fear"} },
    instance = "Dire Maul",
    npc      = "Gordok Warlock",
  },

  -- ===========================================================================
  -- SCHOLOMANCE
  -- ===========================================================================

  [10508] = {
    spells   = { {id = 26070, name = "Fear", type = "fear"} },
    instance = "Scholomance",
    npc      = "Ras Frostwhisper",
  },

  [10502] = {
    spells   = {
      {id = 26070, name = "Fear",          type = "fear"},
      {id = 7645,  name = "Dominate Mind", type = "charm"},
    },
    instance = "Scholomance",
    npc      = "Lady Illucia Barov",
  },

  -- ===========================================================================
  -- STRATHOLME
  -- ===========================================================================

  [11143] = {
    spells   = { {id = 12542, name = "Fear", type = "fear"} },
    instance = "Stratholme",
    npc      = "Postmaster Malown",
  },

  [10409] = {
    spells   = { {id = 6605, name = "Terrifying Screech", type = "fear"} },
    instance = "Stratholme",
    npc      = "Rockwing Screecher",
  },
}
