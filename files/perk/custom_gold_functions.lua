CustomGoldFuncs = {}

CustomGoldFuncs.gold_radioactive = ModSettingGet("prospector-perk.gold_can_harm") and function(amount, data)
    if GameGetGameEffectCount(data.owner, "PROTECTION_RADIOACTIVITY") > 0 then return end --if player is toxic immune, early return
    EntityInflictDamage(
        data.owner, amount * .0005, "DAMAGE_RADIOACTIVE", --target, amount, type
        GameTextGet("$damage_frommaterial", GameTextGetTranslatedOrNot("$mat_gold_radioactive")) or "", --death message
        "NONE", 0, 0 --junk, this function should not require 7 parameters.
    )
end

--append this file to add custom funcs and whatnot