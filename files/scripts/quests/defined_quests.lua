local defined_quests = {
  {
    id = "quest_collect_gold",
    name = "$noita_quest.quest_collect_gold_name",
    description = "$noita_quest.quest_collect_gold_description",
    icon_file = "data/ui_gfx/perk_icons/extra_money.png",
    entity_file = "mods/noita-quest/files/entities/quests/quest_collect_gold.xml",
    difficulties = { 1, 2, 3, 4, 5, 6, 7 },
    time_secs = { 100, 60 * 4, 60 * 9, 60 * 15, 60 * 20, 60 * 25, 60 * 30, 60 * 35 },
    time_fluctuation = 20,
    targets = { 100, 200, 300, 500, 900, 1100, 1500 },
  },
  {
    id = "quest_collect_heart",
    name = "$noita_quest.quest_collect_heart_name",
    description = "$noita_quest.quest_collect_heart_description",
    icon_file = "data/ui_gfx/perk_icons/hearts_more_extra_hp.png",
    entity_file = "mods/noita-quest/files/entities/quests/quest_collect_heart.xml",
    difficulties = { 1, 2, 3, 4, 5, 6, 7 },
    time_secs = { 60 * 3, 60 * 6, 60 * 9, 60 * 30, 60 * 20, 60 * 25, 60 * 30, 60 * 35 },
    time_fluctuation = 30,
    targets = { 1, 2, 3, 4, 5, 6, 7 },
  }
}

return defined_quests
