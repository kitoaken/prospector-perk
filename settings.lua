dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "prospector-perk"
mod_settings_version = 1

mod_settings = {
  {
    id = "enable_holy_mountains",
    ui_name = "Spawns in Holy Mountains",
    ui_description = "Add Prospector to the Holy Mountain perk pool",
    value_default = true,
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
  {
    id = "spawn_gold_room",
    ui_name = "Always spawn in (spoilers)",
    ui_description = "Always spawn Prospector in a well-hidden location...",
    value_default = true,
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
}

function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end
