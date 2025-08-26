--main entity stuff
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local vacuum_inventory = EntityGetFirstComponent(entity_id, "MaterialInventoryComponent")
if not vacuum_inventory then return end
local stored_gold = ComponentGetValue2(vacuum_inventory, "count_per_material_type")

--player and wallet stuff
local owner = EntityGetParent(entity_id) --check closest player for compatibility with multiplayer mods
if owner == 0 then print("owner not found for prospector") return end
local wallet = EntityGetFirstComponent(owner, "WalletComponent")
if wallet == nil then return end

local income = 0 --income is up here so custom funcs can access it
CustomGoldFuncs = {
    gold_radioactive = ModSettingGet("prospector-perk.gold_can_harm") or true and function(amount, data)
        if GameGetGameEffectCount(data.owner, "PROTECTION_RADIOACTIVITY") > 0 then return end --if player is toxic immune, early return
        EntityInflictDamage(
            data.owner, amount * .0005, "DAMAGE_RADIOACTIVE", --target, amount, type
            GameTextGet("$damage_frommaterial", GameTextGetTranslatedOrNot("$mat_gold_radioactive")) or "", --death message
            "NONE", 0, 0 --junk
        )
    end
}

for i, amount in ipairs(stored_gold) do
    if amount ~= 0 then
        local material_name = CellFactory_GetName(i - 1)
        local skip_code
        if CustomGoldFuncs[material_name] then
            local _amount
            _amount,skip_code = CustomGoldFuncs[material_name](amount, {entity_id = entity_id,x = x,y = y, owner = owner})
            amount = _amount or amount --do this cuz "or" failsafes are lame with multi-return|nil functions 
        end
        if not skip_code then --do this in case a mod wants to implement custom behaviour in favour of default behaviour
            GameEntityPlaySoundLoop(GetUpdatedEntityID(), "range_gold_sound", 0.1) --okay i was going to add a hook for custom sound BUT even i recognise egregious feature creep when i see it. -K
	        income = income + amount
            AddMaterialInventoryMaterial(entity_id, material_name, 0)
        end
    end
end

ComponentSetValue2(wallet, "money", ComponentGetValue2(wallet, "money") + income)