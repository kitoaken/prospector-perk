table.insert(perk_list,
  {
    id = "ALFR_PROSPECTOR",
    ui_name = "$perkname_alfr_prospector",
    ui_description = "$perkdesc_alfr_prospector",
    ui_icon = "mods/prospector-perk/files/perk/prospector.png",
    perk_icon = "mods/prospector-perk/files/perk/prospector.png",
    stackable = STACKABLE_NO,
    not_in_default_perk_pool = not ModSettingGet("prospector-perk.enable_holy_mountains"),
    usable_by_enemies = false,
    func = function( entity_perk_item, entity_who_picked, item_name )

      local current_perks = EntityGetAllChildren(entity_who_picked, "perk_entity") or {}
      for _, v in ipairs(current_perks) do
        if ( EntityGetName( v ) == "ALFR_PROSPECTOR" ) then
          return
        end
      end

      -- This flag is only to prevent the Prospector perk spawning in the Gold Room if the player
      -- already has the perk. No need to remove the flag when using Nullifying Altar etc
      GameAddFlagRun("PROSPECTOR_NO_GOLD_BIOME")

      local x,y = EntityGetTransform( entity_who_picked )
      EntityAddChild( entity_who_picked, EntityLoad("mods/prospector-perk/files/perk/prospector.xml", x, y))
    end,
    _remove = function(entity_id)
      for _, child in ipairs(EntityGetAllChildren(entity_id) or {}) do
        if EntityGetName(child) == "ALFR_PROSPECTOR" then
          EntityKill(child)
          break
        end
      end
    end
  }
)