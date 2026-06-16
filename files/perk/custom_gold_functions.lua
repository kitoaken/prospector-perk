ProspectorGoldFuncs = {}

ProspectorGoldFuncs = {
    default = function(d)
        local wallet = d.pdata.wallet
        local income = d.amount * d.worth
        ComponentSetValue2(wallet, "money", ComponentGetValue2(wallet, "money") + income)
        GameEntityPlaySoundLoop(GetUpdatedEntityID(), "range_gold_sound", 0.1)
        AddMaterialInventoryMaterial(d.pdata.entity_id, d.material_name, 0)
    end,

    gold_radioactive = ModSettingGet("prospector-perk.gold_can_harm") and {
        func = function(d)
            ProspectorGoldFuncs.default(d)
            if GameGetGameEffectCount(d.pdata.owner, "PROTECTION_RADIOACTIVITY") > 0 then return end --if player is toxic immune, early return
            EntityInflictDamage(
                d.pdata.owner, d.amount * d.worth * .0005, "DAMAGE_RADIOACTIVE", --target, amount, type
                GameTextGet("$damage_frommaterial", GameTextGetTranslatedOrNot("$mat_gold_radioactive")) or "", --death message
                "NONE", 0, 0 --junk, this function should not require 7 parameters.
            )
        end
    }
}

--append this file to add custom funcs and whatnot