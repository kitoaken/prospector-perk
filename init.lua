local translations = ModTextFileGetContent("data/translations/common.csv") or ""
translations = translations .. ModTextFileGetContent( "mods/prospector-perk/standard.csv" )
ModTextFileSetContent("data/translations/common.csv", translations)

ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/prospector-perk/files/perk/append_perk_list.lua")

local nxml = dofile_once("mods/prospector-perk/lib/nxml.lua")

for xml in nxml.edit_file("data/biome/gold.xml") do
    local topology = xml:first_of("Topology")
    if topology then
        if topology.attr.lua_script ~= nil then
            ModLuaFileAppend(topology.attr.lua_script, "mods/prospector-perk/files/biome/gold_biome.lua")
        else
            topology.attr.lua_script ="mods/prospector-perk/files/biome/gold_biome.lua"
        end
    end
end
