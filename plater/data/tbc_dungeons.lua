-- =============================================================================
-- TBC DUNGEONS DATABASE
-- NPCs in TBC dungeon instances that cast Fear, Charm, or Sleep effects
-- removable by Tremor Totem.
-- =============================================================================

return {
  -- ===========================================================================
  -- HELLFIRE RAMPARTS (Instance 543)
  -- ===========================================================================

  [17269] = {
    spells   = { {id = 12542, name = "Fear", type = "fear"} },
    instance = "Hellfire Ramparts",
    npc      = "Bleeding Hollow Darkcaster",
  },

  [17536] = {
    spells   = { {id = 39427, name = "Bellowing Roar", type = "fear"} },
    instance = "Hellfire Ramparts",
    npc      = "Nazan",
  },

  -- ===========================================================================
  -- THE BLOOD FURNACE (Instance 542)
  -- ===========================================================================

  [17381] = {
    spells   = { {id = 30923, name = "Domination", type = "charm"} },
    instance = "The Blood Furnace",
    npc      = "The Maker",
  },

  -- ===========================================================================
  -- THE SHATTERED HALLS (Instance 540)
  -- ===========================================================================

  [16807] = {
    spells   = { {id = 30500, name = "Death Coil", type = "fear"} },
    instance = "The Shattered Halls",
    npc      = "Grand Warlock Nethekurse",
  },

  [16809] = {
    spells   = { {id = 30584, name = "Fear", type = "fear"} },
    instance = "The Shattered Halls",
    npc      = "Warbringer O'mrogg",
  },

  [17694] = {
    spells   = { {id = 27641, name = "Fear", type = "fear"} },
    instance = "The Shattered Halls",
    npc      = "Shadowmoon Darkcaster",
  },

  -- ===========================================================================
  -- THE STEAMVAULT (Instance 545)
  -- ===========================================================================

  [17801] = {
    spells   = { {id = 31729, name = "Fear", type = "fear"} },
    instance = "The Steamvault",
    npc      = "Coilfang Siren",
  },

  -- ===========================================================================
  -- THE SLAVE PENS (Instance 547)
  -- ===========================================================================

  [17960] = {
    spells   = { {id = 30923, name = "Domination", type = "charm"} },
    instance = "The Slave Pens",
    npc      = "Coilfang Soothsayer",
  },

  [17961] = {
    spells   = { {id = 30923, name = "Domination", type = "charm"} },
    instance = "The Slave Pens",
    npc      = "Coilfang Enchantress",
  },

  -- ===========================================================================
  -- AUCHENAI CRYPTS (Instance 558)
  -- ===========================================================================

  [18373] = {
    spells   = { {id = 32421, name = "Soul Scream", type = "charm"} },
    instance = "Auchenai Crypts",
    npc      = "Exarch Maladaar",
  },

  -- ===========================================================================
  -- SETHEKK HALLS (Instance 556)
  -- ===========================================================================

  [18325] = {
    spells   = { {id = 27641, name = "Fear", type = "fear"} },
    instance = "Sethekk Halls",
    npc      = "Sethekk Prophet",
  },

  -- ===========================================================================
  -- SHADOW LABYRINTH (Instance 555)
  -- ===========================================================================

  [18639] = {
    spells   = { {id = 33502, name = "Brain Wash", type = "charm"} },
    instance = "Shadow Labyrinth",
    npc      = "Cabal Spellbinder",
  },

  [18731] = {
    spells   = { {id = 33547, name = "Fear", type = "fear"} },
    instance = "Shadow Labyrinth",
    npc      = "Ambassador Hellmaw",
  },

  [18667] = {
    spells   = { {id = 33676, name = "Incite Chaos", type = "charm"} },
    instance = "Shadow Labyrinth",
    npc      = "Blackheart the Inciter",
  },

  -- ===========================================================================
  -- THE MECHANAR (Instance 554)
  -- ===========================================================================

  [19220] = {
    spells   = { {id = 35280, name = "Domination", type = "charm"} },
    instance = "The Mechanar",
    npc      = "Pathaleon the Calculator",
  },

  -- ===========================================================================
  -- THE ARCATRAZ (Instance 552)
  -- ===========================================================================

  [20875] = {
    spells   = { {id = 13704, name = "Psychic Scream", type = "fear"} },
    instance = "The Arcatraz",
    npc      = "Negaton Screamer",
  },

  [20902] = {
    spells   = { {id = 39048, name = "Fear", type = "fear"} },
    instance = "The Arcatraz",
    npc      = "Sargeron Hellcaller",
  },

  -- ===========================================================================
  -- THE BOTANICA (Instance 553)
  -- ===========================================================================

  [19513] = {
    spells   = { {id = 30584, name = "Fear", type = "fear"} },
    instance = "The Botanica",
    npc      = "Mutate Fear-Shrieker",
  },

  -- ===========================================================================
  -- OLD HILLSBRAD FOOTHILLS (Instance 560)
  -- ===========================================================================

  [17833] = {
    spells   = { {id = 22884, name = "Psychic Scream", type = "fear"} },
    instance = "Old Hillsbrad Foothills",
    npc      = "Durnholde Warden",
  },

  -- ===========================================================================
  -- MAGISTERS' TERRACE (Instance 585)
  -- ===========================================================================

  [24560] = {
    spells   = { {id = 22884, name = "Psychic Scream", type = "fear"} },
    instance = "Magisters' Terrace",
    npc      = "Priestess Delrissa",
  },

  [24558] = {
    spells   = { {id = 38595, name = "Fear", type = "fear"} },
    instance = "Magisters' Terrace",
    npc      = "Ellrys Duskhallow",
  },

  [24559] = {
    spells   = { {id = 19134, name = "Frightening Shout", type = "fear"} },
    instance = "Magisters' Terrace",
    npc      = "Warlord Salaris",
  },
}
