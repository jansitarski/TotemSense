-- =============================================================================
-- CONFIGURATION MODULE
-- Customize icon appearance and behavior here.
-- =============================================================================

local cfg = {
  -- Icon appearance
  iconSize    = 20,      -- Icon width and height in pixels
  iconTexture = "Interface\\Icons\\Spell_Nature_TremorTotem",
  
  -- Icon positioning
  xOffset     = -2,      -- Horizontal offset from RIGHT anchor (negative = left)
  yOffset     = 0,       -- Vertical offset from center
  anchorPoint = "RIGHT", -- Anchor point on the health bar
  
  -- Alternative icon options (uncomment to use):
  -- iconTexture = "Interface\\Icons\\Spell_Shaman_ImprovedReincarnation",  -- Glowing totem
  -- iconTexture = "Interface\\Icons\\Ability_Shaman_TotemRecall",          -- Totem Recall
}

return cfg
