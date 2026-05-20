-- =============================================================================
-- NAMEPLATE ADDED HOOK  (signature: function(self, unitId, unitFrame, envTable))
-- Runs every time a nameplate becomes visible.
-- Determines whether to show the CC indicator icon.
-- =============================================================================
-- INSTALLATION: Paste the code below into the "Nameplate Added" hook in Plater Modding tab.
-- =============================================================================

-- Always hide any leftover icon first (frame recycling defense)
if unitFrame.TotemSenseIcon then
  unitFrame.TotemSenseIcon:Hide()
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
    -- TBC Classic uses hex GUID format (0xF1300073AB06AE87)
    -- NPC ID is at positions 7-10 (hex digits)
    npcId = tonumber(guid:sub(7, 10), 16)
  end
end
if not npcId then return end

-- Look up in the database
if not envTable.FearDatabase[npcId] then return end

-- Create or reuse the icon texture
local cfg = envTable.cfg
local icon = unitFrame.TotemSenseIcon
if not icon then
  icon = unitFrame.healthBar:CreateTexture(nil, "OVERLAY")
  unitFrame.TotemSenseIcon = icon
end

local barHeight = unitFrame.healthBar:GetHeight()
local size = barHeight * cfg.iconScale

icon:SetTexture(cfg.iconTexture)
icon:SetWidth(size)
icon:SetHeight(size)
icon:ClearAllPoints()
icon:SetPoint(cfg.anchorPoint, unitFrame.healthBar, cfg.anchorPoint, cfg.xOffset, cfg.yOffset)

icon:Show()
