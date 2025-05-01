local translations = ModTextFileGetContent( "data/translations/common.csv" ) or ""
translations = translations .. ModTextFileGetContent( "mods/prospector-perk/files/translations/common-append.csv" )
ModTextFileSetContent( "data/translations/common.csv", translations )

ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/prospector-perk/files/scripts/perk_list.lua")