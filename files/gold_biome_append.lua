dofile_once("mods/prospector-perk/files/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init(x, y, w, h)

    local spawn_gold_room = ModSettingGet("prospector-perk.spawn_gold_room")

    if spawn_gold_room and not GameHasFlagRun("PROSPECTOR_NO_GOLD_BIOME") then
        local altar = "mods/prospector-perk/files/biome_impl/prospector_altar.png"
        local altar_visual = "mods/prospector-perk/files/biome_impl/prospector_altar_visual.png"
        LoadPixelScene( altar, altar_visual , x+222, y+500, "", true )
        perk_spawn( x + 256, y + 490, "ALFR_PROSPECTOR")
        GameAddFlagRun("PROSPECTOR_NO_GOLD_BIOME")
    end
end