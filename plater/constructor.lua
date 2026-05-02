-- =============================================================================
-- CONSTRUCTOR HOOK
-- Runs once when the mod loads. Initializes configuration and NPC database.
-- =============================================================================
-- INSTALLATION: Copy this entire file into the "Constructor" hook in Plater Modding tab.
-- =============================================================================

function(self, envTable)
  -- ---------------------------------------------------------------------------
  -- CONFIGURATION
  -- ---------------------------------------------------------------------------
  
  local cfg = {
    iconSize    = 20,
    iconTexture = "Interface\\Icons\\Spell_Nature_TremorTotem",
    xOffset     = -2,
    yOffset     = 0,
    anchorPoint = "RIGHT",
  }
  envTable.cfg = cfg
  
  -- ---------------------------------------------------------------------------
  -- NPC DATABASE (Generated from database/*.json)
  -- ---------------------------------------------------------------------------
  
  envTable.FearDatabase = {
  -- CLASSIC DUNGEONS
  [3671] = { spells = {{id=8040, name="Druid's Slumber", type="sleep"}}, instance="Wailing Caverns", npc="Lady Anacondra" },
  [3669] = { spells = {{id=8040, name="Druid's Slumber", type="sleep"}}, instance="Wailing Caverns", npc="Lord Cobrahn" },
  [3670] = { spells = {{id=8040, name="Druid's Slumber", type="sleep"}}, instance="Wailing Caverns", npc="Lord Pythas" },
  [3673] = { spells = {{id=8040, name="Druid's Slumber", type="sleep"}}, instance="Wailing Caverns", npc="Lord Serpentis" },
  [3840] = { spells = {{id=8040, name="Druid's Slumber", type="sleep"}}, instance="Wailing Caverns", npc="Druid of the Fang" },
  [2529] = { spells = {{id=7399, name="Terrify", type="fear"}}, instance="Shadowfang Keep", npc="Son of Arugal" },
  [3872] = { spells = {{id=7399, name="Terrify", type="fear"}}, instance="Shadowfang Keep", npc="Deathsworn Captain" },
  [4518] = { spells = {{id=12542, name="Fear", type="fear"}}, instance="Razorfen Kraul", npc="Death's Head Sage" },
  [6490] = { spells = {{id=7399, name="Terrify", type="fear"}}, instance="Scarlet Monastery", npc="Azshir the Sleepless" },
  [3977] = { spells = {{id=9256, name="Deep Sleep", type="sleep"}, {id=14515, name="Dominate Mind", type="charm"}}, instance="Scarlet Monastery", npc="High Inquisitor Whitemane" },
  [5271] = { spells = {{id=12542, name="Fear", type="fear"}}, instance="Sunken Temple", npc="Atal'ai Deathwalker" },
  [8895] = { spells = {{id=5246, name="Intimidating Shout", type="fear"}}, instance="Blackrock Depths", npc="Anvilrage Officer" },
  [9218] = { spells = {{id=19134, name="Frightening Shout", type="fear"}}, instance="Lower Blackrock Spire", npc="Spirestone Battle Lord" },
  [9217] = { spells = {{id=12542, name="Fear", type="fear"}}, instance="Lower Blackrock Spire", npc="Spirestone Lord Magus" },
  [10430] = { spells = {{id=14100, name="Terrifying Roar", type="fear"}}, instance="Upper Blackrock Spire", npc="The Beast" },
  [11445] = { spells = {{id=12542, name="Fear", type="fear"}}, instance="Dire Maul", npc="Gordok Captain" },
  [11448] = { spells = {{id=12542, name="Fear", type="fear"}}, instance="Dire Maul", npc="Gordok Warlock" },
  [10508] = { spells = {{id=26070, name="Fear", type="fear"}}, instance="Scholomance", npc="Ras Frostwhisper" },
  [10502] = { spells = {{id=26070, name="Fear", type="fear"}, {id=7645, name="Dominate Mind", type="charm"}}, instance="Scholomance", npc="Lady Illucia Barov" },
  [11143] = { spells = {{id=12542, name="Fear", type="fear"}}, instance="Stratholme", npc="Postmaster Malown" },
  [10409] = { spells = {{id=6605, name="Terrifying Screech", type="fear"}}, instance="Stratholme", npc="Rockwing Screecher" },

  -- CLASSIC RAIDS
  [11673] = { spells = {{id=19408, name="Panic", type="fear"}}, instance="Molten Core", npc="Ancient Core Hound" },
  [11982] = { spells = {{id=19408, name="Panic", type="fear"}}, instance="Molten Core", npc="Magmadar" },
  [10184] = { spells = {{id=18431, name="Bellowing Roar", type="fear"}}, instance="Onyxia's Lair", npc="Onyxia" },
  [10162] = { spells = {{id=22678, name="Fear", type="fear"}}, instance="Blackwing Lair", npc="Lord Victor Nefarius" },
  [11583] = { spells = {{id=22686, name="Bellowing Roar", type="fear"}}, instance="Blackwing Lair", npc="Nefarian" },
  [12467] = { spells = {{id=15588, name="Frightening Shout", type="fear"}}, instance="Blackwing Lair", npc="Death Talon Captain" },
  [14517] = { spells = {{id=22884, name="Psychic Scream", type="fear"}}, instance="Zul'Gurub", npc="High Priestess Jeklik" },
  [11352] = { spells = {{id=19134, name="Frightening Shout", type="fear"}}, instance="Zul'Gurub", npc="Gurubashi Berserker" },
  [11382] = { spells = {{id=19134, name="Intimidating Shout", type="fear"}}, instance="Zul'Gurub", npc="Bloodlord Mandokir" },
  [15543] = { spells = {{id=26580, name="Fear", type="fear"}}, instance="Temple of Ahn'Qiraj", npc="Princess Yauj" },
  [15247] = { spells = {{id=785, name="True Fulfillment", type="charm"}}, instance="Temple of Ahn'Qiraj", npc="Qiraji Brainwasher" },
  [15509] = { spells = {{id=26180, name="Wyvern Sting", type="sleep"}}, instance="Temple of Ahn'Qiraj", npc="Princess Huhuran" },
  [15932] = { spells = {{id=29685, name="Terrifying Roar", type="fear"}}, instance="Naxxramas", npc="Gluth" },
  [15990] = { spells = {{id=28410, name="Chains of Kel'Thuzad", type="charm"}}, instance="Naxxramas", npc="Kel'Thuzad" },

  -- TBC DUNGEONS
  [17269] = { spells = {{id=12542, name="Fear", type="fear"}}, instance="Hellfire Ramparts", npc="Bleeding Hollow Darkcaster" },
  [17536] = { spells = {{id=39427, name="Bellowing Roar", type="fear"}}, instance="Hellfire Ramparts", npc="Nazan" },
  [17381] = { spells = {{id=30923, name="Domination", type="charm"}}, instance="The Blood Furnace", npc="The Maker" },
  [16807] = { spells = {{id=30500, name="Death Coil", type="fear"}}, instance="The Shattered Halls", npc="Grand Warlock Nethekurse" },
  [16809] = { spells = {{id=30584, name="Fear", type="fear"}}, instance="The Shattered Halls", npc="Warbringer O'mrogg" },
  [17694] = { spells = {{id=27641, name="Fear", type="fear"}}, instance="The Shattered Halls", npc="Shadowmoon Darkcaster" },
  [17801] = { spells = {{id=31729, name="Fear", type="fear"}}, instance="The Steamvault", npc="Coilfang Siren" },
  [17960] = { spells = {{id=30923, name="Domination", type="charm"}}, instance="The Slave Pens", npc="Coilfang Soothsayer" },
  [17961] = { spells = {{id=30923, name="Domination", type="charm"}}, instance="The Slave Pens", npc="Coilfang Enchantress" },
  [18373] = { spells = {{id=32421, name="Soul Scream", type="charm"}}, instance="Auchenai Crypts", npc="Exarch Maladaar" },
  [18325] = { spells = {{id=27641, name="Fear", type="fear"}}, instance="Sethekk Halls", npc="Sethekk Prophet" },
  [18639] = { spells = {{id=33502, name="Brain Wash", type="charm"}}, instance="Shadow Labyrinth", npc="Cabal Spellbinder" },
  [18731] = { spells = {{id=33547, name="Fear", type="fear"}}, instance="Shadow Labyrinth", npc="Ambassador Hellmaw" },
  [18667] = { spells = {{id=33676, name="Incite Chaos", type="charm"}}, instance="Shadow Labyrinth", npc="Blackheart the Inciter" },
  [19220] = { spells = {{id=35280, name="Domination", type="charm"}}, instance="The Mechanar", npc="Pathaleon the Calculator" },
  [20875] = { spells = {{id=13704, name="Psychic Scream", type="fear"}}, instance="The Arcatraz", npc="Negaton Screamer" },
  [20902] = { spells = {{id=39048, name="Fear", type="fear"}}, instance="The Arcatraz", npc="Sargeron Hellcaller" },
  [19513] = { spells = {{id=30584, name="Fear", type="fear"}}, instance="The Botanica", npc="Mutate Fear-Shrieker" },
  [17833] = { spells = {{id=22884, name="Psychic Scream", type="fear"}}, instance="Old Hillsbrad Foothills", npc="Durnholde Warden" },
  [24560] = { spells = {{id=22884, name="Psychic Scream", type="fear"}}, instance="Magisters' Terrace", npc="Priestess Delrissa" },
  [24558] = { spells = {{id=38595, name="Fear", type="fear"}}, instance="Magisters' Terrace", npc="Ellrys Duskhallow" },
  [24559] = { spells = {{id=19134, name="Frightening Shout", type="fear"}}, instance="Magisters' Terrace", npc="Warlord Salaris" },

  -- TBC RAIDS
  [15547] = { spells = {{id=29321, name="Fear", type="fear"}}, instance="Karazhan", npc="Spectral Charger" },
  [15548] = { spells = {{id=29321, name="Fear", type="fear"}}, instance="Karazhan", npc="Spectral Stallion" },
  [17521] = { spells = {{id=30752, name="Terrifying Howl", type="fear"}}, instance="Karazhan", npc="The Big Bad Wolf" },
  [17225] = { spells = {{id=36922, name="Bellowing Roar", type="fear"}}, instance="Karazhan", npc="Nightbane" },
  [18831] = { spells = {{id=16508, name="Intimidating Roar", type="fear"}}, instance="Gruul's Lair", npc="High King Maulgar" },
  [17256] = { spells = {{id=30530, name="Fear", type="fear"}}, instance="Magtheridon's Lair", npc="Hellfire Channeler" },
  [18829] = { spells = {{id=30530, name="Fear", type="fear"}}, instance="Magtheridon's Lair", npc="Hellfire Warder" },
  [21215] = { spells = {{id=37749, name="Madness", type="charm"}}, instance="Serpentshrine Cavern", npc="Leotheras the Blind" },
  [22056] = { spells = {{id=38154, name="Panic", type="fear"}}, instance="Serpentshrine Cavern", npc="Coilfang Strider" },
  [19622] = { spells = {{id=44863, name="Fear", type="fear"}, {id=36797, name="Mind Control", type="charm"}}, instance="Tempest Keep", npc="Kael'thas Sunstrider" },
  [17808] = { spells = {{id=31298, name="Sleep", type="sleep"}}, instance="Hyjal Summit", npc="Anetheron" },
  [17968] = { spells = {{id=31970, name="Fear", type="fear"}}, instance="Hyjal Summit", npc="Archimonde" },
  [22847] = { spells = {{id=19386, name="Wyvern Sting", type="sleep"}}, instance="Black Temple", npc="Ashtongue Primalist" },
  [23576] = { spells = {{id=42398, name="Frightening Roar", type="fear"}}, instance="Zul'Aman", npc="Nalorakk" },
  }
  
end
