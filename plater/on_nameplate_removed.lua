-- =============================================================================
-- NAMEPLATE REMOVED HOOK
-- Runs when a nameplate is hidden or recycled.
-- Always hide the icon to prevent visual bugs from frame recycling.
-- =============================================================================
-- INSTALLATION: Copy this entire file into the "Nameplate Removed" hook in Plater Modding tab.
-- =============================================================================

function(self, unitId, unitFrame, envTable)
  if unitFrame.CCPlatesIcon then
    unitFrame.CCPlatesIcon:Hide()
  end
end
