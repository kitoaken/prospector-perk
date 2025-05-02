local translations = ModTextFileGetContent( "data/translations/common.csv" ) or ""
translations = translations .. ModTextFileGetContent( "mods/prospector-perk/files/translations/common-append.csv" )
ModTextFileSetContent( "data/translations/common.csv", translations )

ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/prospector-perk/files/scripts/perk_list.lua")

local nxml = dofile_once("mods/prospector-perk/files/scripts/lib/nxml.lua")

for xml in nxml.edit_file("data/biome/gold.xml") do
    xml:first_of("Topology"):set("lua_script", "mods/prospector-perk/files/gold_biome_append.lua")
end
