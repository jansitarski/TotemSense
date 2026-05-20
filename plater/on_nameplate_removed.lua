-- =============================================================================
-- NAMEPLATE REMOVED HOOK  (signature: function(self, unitId, unitFrame, envTable))
-- Runs when a nameplate is hidden or recycled.
-- Always hide the icon to prevent visual bugs from frame recycling.
-- =============================================================================
-- INSTALLATION: Paste the code below into the "Nameplate Removed" hook in Plater Modding tab.
-- =============================================================================

if unitFrame.TotemSenseIcon then
  unitFrame.TotemSenseIcon:Hide()
end
