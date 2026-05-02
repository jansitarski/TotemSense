-- =============================================================================
-- DATABASE LOADER
-- Combines all NPC database files into a single table.
-- This module is called from the Constructor hook to build the complete database.
-- =============================================================================

-- To add the database loader to your Constructor:
-- Simply copy the data files content into envTable.FearDatabase = { ... }
-- OR use this loader if you want to keep files separate during development

local function MergeTables(target, source)
  for key, value in pairs(source) do
    target[key] = value
  end
  return target
end

local function LoadDatabase()
  local db = {}
  
  -- Load TBC content
  MergeTables(db, TBC_RAIDS_DATA or {})
  MergeTables(db, TBC_DUNGEONS_DATA or {})
  
  -- Load Classic content
  MergeTables(db, CLASSIC_RAIDS_DATA or {})
  MergeTables(db, CLASSIC_DUNGEONS_DATA or {})
  
  return db
end

return LoadDatabase
