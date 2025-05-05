table.insert(perk_list,
  {
    id = "ALFR_PROSPECTOR",
    ui_name = "$perkname_alfr_prospector",
    ui_description = "$perkdesc_alfr_prospector",
    ui_icon = "mods/prospector-perk/files/ui_gfx/perk_icons/prospector.png",
    perk_icon = "mods/prospector-perk/files/items_gfx/perks/prospector.png",
    stackable = STACKABLE_NO,
    usable_by_enemies = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
      if not GameHasFlagRun("PERK_PICKED_PROSPECTOR") then
        GameAddFlagRun("PERK_PICKED_PROSPECTOR")
          local x,y = EntityGetTransform( entity_who_picked )
          local child_id = EntityLoad( "mods/prospector-perk/files/entities/misc/perks/prospector.xml", x, y )
          EntityAddTag( child_id, "perk_entity" )
          EntityAddChild( entity_who_picked, child_id )

          EntityAddComponent( child_id, "LuaComponent", 
          {
              script_source_file = "mods/prospector-perk/files/scripts/perks/prospector.lua",
              -- This could be every few frames, but there'd be slower gold sounds and some desync with
              -- picking up gold vs it being added to the player wallet
              execute_every_n_frame = "1",
          } )
      end
    end,
    func_remove = function( entity_who_picked )
      if GameHasFlagRun("PERK_PICKED_PROSPECTOR") then
        GameRemoveFlagRun("PERK_PICKED_PROSPECTOR")
      end
    end
  }
)