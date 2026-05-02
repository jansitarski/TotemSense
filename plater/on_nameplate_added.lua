-- =============================================================================
-- NAMEPLATE ADDED HOOK
-- Runs every time a nameplate becomes visible.
-- Determines whether to show the CC indicator icon.
-- =============================================================================
-- INSTALLATION: Copy this entire file into the "Nameplate Added" hook in Plater Modding tab.
-- =============================================================================

function(self, unitId, unitFrame, envTable)
  -- Always hide any leftover icon first (frame recycling defense)
  if unitFrame.CCPlatesIcon then
    unitFrame.CCPlatesIcon:Hide()
  end
  
  -- Skip friendly units and players
  local reaction = UnitReaction(unitId, "player")
  if reaction and reaction >= 5 then return end
  if UnitIsPlayer(unitId) then return end
  
  -- Resolve NPC ID: prefer Plater's exposed field, fall back to GUID parse
  local npcId = unitFrame.namePlateNpcId
  if not npcId then
    local guid = UnitGUID(unitId)
    if guid then
      npcId = tonumber(select(6, strsplit("-", guid)))
    end
  end
  if not npcId then return end
  
  -- Look up in the database
  if not envTable.FearDatabase[npcId] then return end
  
  -- Create or reuse the icon texture
  local cfg = envTable.cfg
  local icon = unitFrame.CCPlatesIcon
  if not icon then
    icon = unitFrame.healthBar:CreateTexture(nil, "OVERLAY")
    icon:SetTexture(cfg.iconTexture)
    icon:SetWidth(cfg.iconSize)
    icon:SetHeight(cfg.iconSize)
    icon:SetPoint(cfg.anchorPoint, unitFrame.healthBar, cfg.anchorPoint, cfg.xOffset, cfg.yOffset)
    unitFrame.CCPlatesIcon = icon
  end
  
  icon:Show()
end
