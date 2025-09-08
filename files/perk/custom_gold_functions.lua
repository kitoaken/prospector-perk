
CustomGoldFuncs = {}

CustomGoldFuncs.gold_radioactive = {
    func = ModSettingGet("prospector-perk.gold_can_harm") and function(self, data) --custom function with a table containing useful data
        if GameGetGameEffectCount(data.owner, "PROTECTION_RADIOACTIVITY") > 0 then return end --if player is toxic immune, early return
        EntityInflictDamage(
            data.owner, data.amount * .0005, "DAMAGE_RADIOACTIVE", --target, amount, type
            GameTextGet("$damage_frommaterial", GameTextGetTranslatedOrNot("$mat_gold_radioactive")) or "", --death message
            "NONE", 0, 0 --junk, this function should not require 7 parameters.
        )
    end,
    override = nil, --whether the regular gold pickup code should be voided
    multiplier = 5, --multiplier applied to the gold (2, -1, 0, etc.)
    sound = "damage/projectile", --sound effect id that should play while gold is being picked up (indepedent from audio_volume)
    sound_volume = 3, --what the sound effect volume should be (indepedent from audio)
}

--[[ here is the data passed into the second field on functions
data = {
    amount = amount of material collected,
    calculated_income = sum of all income calculated before this material was calculated, (i actually dont know why this would be useful)
    entity_id = perk entity id,
    owner = owner entity id,
    wallet = wallet comp on owner (CAN BE NIL),
    x = x position,
    y = y position,
}]]


--append this file to add custom funcs and whatnot