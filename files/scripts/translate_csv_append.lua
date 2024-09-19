local function append_to_translate_csv()
  local original_content = ModTextFileGetContent("data/translations/common.csv")

  local noita_quest_content = ModTextFileGetContent(
    "mods/noita-quest/files/translations/common.csv")

  ModTextFileSetContent("data/translations/common.csv", original_content .. noita_quest_content)
end

append_to_translate_csv()
