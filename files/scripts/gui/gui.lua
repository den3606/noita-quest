local METADATA = dofile_once("mods/noita-quest/files/scripts/metadata.lua")
dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")
local gui = gui or GuiCreate()

local function draw(execute_func)
  GuiStartFrame(gui)
  GuiIdPushString(gui, METADATA.MOD_NAME)
  if not GameIsInventoryOpen() then
    execute_func(gui)
  end
  GuiIdPop(gui)
end

local function string_to_number(str)
  local num = 0
  for i = 1, #str do
    local char = string.sub(str, i, i)
    num = num + string.byte(char)
  end
  return num
end

local keys = {}
local function new_id(key)
  if keys[key] ~= nil then
    return keys[key]
  end

  local global_gui_id = tonumber(ModSettingGet(METADATA.GLOBAL_GUI_ID_KEY)) or 0
  if global_gui_id == 0 then
    global_gui_id = string_to_number(METADATA.MOD_NAME) + 5000
  end

  keys[key] = global_gui_id
  global_gui_id = global_gui_id + 1

  ModSettingSet(METADATA.GLOBAL_GUI_ID_KEY, tostring(global_gui_id))

  return global_gui_id
end

return {
  draw = draw,
  new_id = new_id,
}
