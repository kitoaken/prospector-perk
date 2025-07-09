dofile_once("mods/prospector-perk/files/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local vacuum_inventory = EntityGetFirstComponent(entity_id, "MaterialInventoryComponent")
local stored_gold = ComponentGetValue2(vacuum_inventory, "count_per_material_type")

for i, v in ipairs(stored_gold) do
    if v ~= 0 then
        GameEntityPlaySoundLoop(GetUpdatedEntityID(), "range_gold_sound", 0.1)
        addPlayerGold(v)
        AddMaterialInventoryMaterial(entity_id, CellFactory_GetName(i - 1), 0)
    end
end