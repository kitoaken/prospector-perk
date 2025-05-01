dofile_once("mods/prospector-perk/files/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local vacuum_inventory = EntityGetFirstComponent(entity_id, "MaterialInventoryComponent")
local stored_gold = ComponentGetValue2(vacuum_inventory, "count_per_material_type")[136]

if stored_gold > 0 then
    GameEntityPlaySoundLoop(GetUpdatedEntityID(), "range_gold_sound", 0.1)
    addPlayerGold(stored_gold)
    AddMaterialInventoryMaterial(entity_id, "gold", 0)
end
--GamePlaySound( "data/audio/Desktop/projectiles.bank", "projectiles/magic/create", pos_x, pos_y )