dofile_once("mods/prospector-perk/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

if type(init) ~= "function" then --this is stuff to account for just in case init already exists (does not account for mods adding init function under a diff name, but that would be lunacy and accounting for it is beyond the scope of this mod. will deal with it if it comes up)
    RegisterSpawnFunction( 0xffffeedd, "init" )
else
    prospector_old_init = init
end

function init(x, y, w, h)
    if GetParallelWorldPosition(x, 0) ~= 0 or
        not ModSettingGet("prospector-perk.spawn_gold_room") or
        GameHasFlagRun("PROSPECTOR_NO_GOLD_BIOME") then return 
    end --dont spawn in PW

    LoadPixelScene( 
        "mods/prospector-perk/files/biome/prospector_altar.png",
        "mods/prospector-perk/files/biome/prospector_altar_visual.png",
        x+222, y+500, "", true
    )
    perk_spawn( x + 256, y + 490, "ALFR_PROSPECTOR")
    GameAddFlagRun("PROSPECTOR_NO_GOLD_BIOME")

    if prospector_old_init then prospector_old_init(x, y, w, h) end --run old init if it exists
end