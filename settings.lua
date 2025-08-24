dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "prospector-perk"
mod_settings_version = 1

local languages = { --translation keys
    ["English"] = "en",
    ["русский"] = "ru",
    ["Português (Brasil)"] = "ptbr",
    ["Español"] = "eses",
    ["Deutsch"] = "de",
    ["Français"] = "frfr",
    ["Italiano"] = "it",
    ["Polska"] = "pl",
    ["简体中文"] = "zhcn",
    ["日本語"] = "jp",
    ["한국어"] = "ko",
}

local current_lang = languages[GameTextGetTranslatedOrNot("$current_language")]

local translations = {
    enable_holy_mountains = {
        en = "Spawns in Holy Mountains",
        en_desc = "Add Prospector to the Holy Mountain perk pool",
    },
    spawn_gold_room = {
        en = "Always spawn in (spoilers)",
        en_desc = "Always spawn Prospector in a well-hidden location...",
    },
}

mod_settings = {
  {
    id = "enable_holy_mountains",
    value_default = true,
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
  {
    id = "spawn_gold_room",
    value_default = true,
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
}

function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id)
    for index, setting in ipairs(mod_settings) do
        if translations[setting.id] then
            setting.ui_name = translations[setting.id][current_lang] or translations[setting.id].en or "EMPTY TRANSLATION!"
            setting.ui_description = translations[setting.id][current_lang] or translations[setting.id].en_desc or "EMPTY TRANSLATION!"
        end
    end
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end
