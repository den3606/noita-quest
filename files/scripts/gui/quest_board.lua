Gui = dofile_once("mods/noita-quest/files/scripts/gui/gui.lua")

local function draw_quest_board(gui, assigned_quests)
  -- TODO: 死亡後も表示するかは検討
  local player_entity_id = GetPlayerEntity()
  if not player_entity_id then
    return
  end


  if #assigned_quests ~= 0 then
    -- パークみたいにリストだけで出すほうがいいかも
    -- 以下のような表記にして、ホバー時に詳細を出す
    -- 詳細内容は、成功したときの報酬と失敗したときの罰
    -- Quests
    -- └⏰🔫 King of Shotgunner [0/15] -> 放射物を同時に15発だす
    -- └⏰💰️ Collect Gold [150g/200g]
    -- └⏰⤵️ Down Down Down [70m/400m]
    -- └⏰🐉 Beat Dragon [0/1]
    -- └✅💰️ You are rich [220g/200g]
    -- └❎💓 Strong Heart [0/3]
    -- 15, 73
    -- GuiLayoutBeginVertical(gui, 15, 73)
    GuiLayoutBeginVertical(gui, 15, 75, true, 0, 0)

    for index, quest in ipairs(assigned_quests) do
      GuiLayoutBeginHorizontal(gui, 0, 0, true, -3, -4)
      GuiImageButton(gui, Gui.new_id('quest_status_' .. index), 0, 0, "",
        "data/ui_gfx/perk_icons/perks_lottery.png")
      GuiImageButton(gui, Gui.new_id('quest_icon_' .. index), 0, 0, "",
        "data/ui_gfx/perk_icons/perks_lottery.png")
      GuiText(gui, 4, 2.5, quest.time_sec .. "s " .. quest.name)
      GuiLayoutEnd(gui)
    end
    GuiLayoutEnd(gui)

    -- if ((show_button_in_inventory_only and (inventory_is_open or is_open)) or not show_button_in_inventory_only) and then
    --   is_open = not is_open
    --   if is_open then
    --     rebuild_perk_table()
    --     if show_button_in_inventory_only and inventory_gui_comp then
    --       ComponentSetValue2(inventory_gui_comp, "mActive", false)
    --     end
    --   end
    -- end
  end
end

return {
  draw_quest_board = draw_quest_board,
}
