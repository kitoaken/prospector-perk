--main entity stuff
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local vacuum_inventory = EntityGetFirstComponent(entity_id, "MaterialInventoryComponent")
if not vacuum_inventory then return end
local stored_gold = ComponentGetValue2(vacuum_inventory, "count_per_material_type")

--owner and wallet stuff
local owner = EntityGetParent(entity_id)
if owner == 0 then print("owner not found for prospector") return end
local wallet = EntityGetFirstComponent(owner, "WalletComponent")
if wallet == nil then return end

dofile_once("mods/prospector-perk/files/perk/custom_gold_functions.lua")

for i, amount in ipairs(stored_gold) do
    if amount ~= 0 then
        local material_name = CellFactory_GetName(i - 1)
        local data = {
            pdata = persistent_data,
            material_name = material_name,
            amount = amount,
            worth = 1,
        }
        if ProspectorGoldFuncs[material_name] then
			for key, value in pairs(ProspectorGoldFuncs[material_name]) do
				data[key] = value
			end
        end
		if data.func then data:func() else ProspectorGoldFuncs.default(data) end
    end
end