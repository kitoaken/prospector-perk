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

dofile_once("mods/prospector-perk/files/perk/custom_gold_functions.lua")

local income = 0
for i, amount in ipairs(stored_gold) do
    if amount ~= 0 then
        local material_name = CellFactory_GetName(i - 1)
        local override
        local sound = "range_gold_sound"
        local sound_volume = 0.1
        if CustomGoldFuncs[material_name] then
            local mdata = CustomGoldFuncs[material_name]
            if mdata.func then mdata:func({
                amount = amount,
                entity_id = entity_id,
                owner = owner,
                wallet = wallet, --wallet can be nil
                x = x,
                y = y,
            }) end --this seems like a lot, but it only runs if a material with a custom function is currently being picked up (im telling myself that so i dont worry about running this every frame) -K
            override = mdata.override
            if mdata.multiplier then amount = amount * mdata.multiplier end
            sound = mdata.sound or sound
            sound_volume = mdata.sound_volume or sound

        end
        if not override then --do this in case a mod wants to implement custom behaviour in favour of default behaviour
            GameEntityPlaySoundLoop(entity_id, sound, sound_volume) --egregious feature creep :( -K
            income = income + amount --accumulate income amount
            AddMaterialInventoryMaterial(entity_id, material_name, 0) --remove material from material inventory
        end
    end
end

if wallet == nil then return end --should totally add enemy support here, would be funny if they could collect gold around them and then dropped it on death
if income ~= 0 then ComponentSetValue2(wallet, "money", ComponentGetValue2(wallet, "money") + income) end