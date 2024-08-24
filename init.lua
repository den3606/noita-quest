dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")
local Coil = dofile_once("mods/noita-quest/files/scripts/lib/coil/coil.lua")
local QuestManager = dofile_once("mods/noita-quest/files/scripts/quest_manager.lua")
local Gui = dofile_once("mods/noita-quest/files/scripts/gui/gui.lua")
local QuestBoardGui = dofile_once("mods/noita-quest/files/scripts/gui/quest_board.lua")
local QUEST = dofile_once("mods/noita-quest/files/scripts/quests/quest_names.lua")

print("noita-quest load")

function OnModPreInit()
  -- print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
  -- print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
  -- print("Mod - OnModPostInit()") -- Then this is called for all mods
end

function OnPlayerSpawned(player_entity)
  -- playerが選んだクエスト
  local player_picked_quest_ids = { QUEST.COLLECT_GOLD, QUEST.COLLECT_GOLD }
  QuestManager.add(player_picked_quest_ids)
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
  -- GamePrint("OnWorldInitialized() " .. tostring(GameGetFrameNum()))
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
  -- GamePrint("Pre-update hook " .. tostring(GameGetFrameNum()))
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
  Gui.draw(function(gui)
    QuestBoardGui.draw_quest_board(gui, QuestManager.get_assigned_quest_entities())
  end)
end

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
  -- print("===================================== random " .. tostring(x))
end

print("noita-quest loaded")
