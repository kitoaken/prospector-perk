--adding translations to the game without slightly breaking stuff is annoying, this code here avoids breaking it and unbreaks it if someone else broke it before us, similar to code used in Apotheosis i think
local translations = ModTextFileGetContent("data/translations/common.csv")
translations = translations .. "\n" .. ModTextFileGetContent("mods/prospector-perk/standard.csv") .. "\n"
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)

--add perk
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/prospector-perk/files/perk/append_perk_list.lua")


local nxml = dofile_once("mods/prospector-perk/lib/nxml.lua")

--dont spawn perk in gold if setting isnt set
if ModSettingGet("prospector-perk.spawn_gold_room") then
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
end

--use [wallet_money] for more ideal compatibility
for xml in nxml.edit_file("data/materials.xml") do
	for elem in xml:each_child() do
        if elem.attr.name == "gold" or elem.attr.name == "gold_radioactive" then elem.attr.tags = elem.attr.tags .. ",[wallet_money]" end
    end
end