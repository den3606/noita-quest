local assigned_quests = {}

local function add(quest_names)
  for index, value in ipairs(quest_names) do
    -- TODO:取得時に失敗したときはスルーする実装を追加する
    local quest = dofile_once("mods/noita-quest/files/scripts/quests/quest_" .. value .. ".lua")
    table.insert(assigned_quests, quest.new())
  end
end

local function update()
  for index, quest in ipairs(assigned_quests) do
    quest.update(quest)

    GamePrint(quest.name .. 'のステータスは ' .. quest.status .. 'です')
    GamePrint(quest.name .. 'の残り時間は ' .. quest.quest_time_sec .. 'です')
  end
end

return {
  add = add,
  update = update
}
