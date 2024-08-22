dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")
Coil = dofile_once("mods/noita-quest/files/scripts/lib/coil/coil.lua")
QuestManager = dofile_once("mods/noita-quest/files/scripts/quest_manager.lua")

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
  Coil.add(function()
    -- playerが選んだクエスト
    local player_picked_quest_names = { 'collect_gold' }
    QuestManager.add(player_picked_quest_names)
    while true do
      QuestManager.update()
      Coil.wait(60)
    end
  end)
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
  -- GamePrint("OnWorldInitialized() " .. tostring(GameGetFrameNum()))
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
  -- GamePrint("Pre-update hook " .. tostring(GameGetFrameNum()))
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
  Coil.update(1)
end

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
  -- print("===================================== random " .. tostring(x))
end

print("noita-quest loaded")
