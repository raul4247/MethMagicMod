_G.MethMagic = {}
MethMagic._path = ModPath
MethMagic._config_path = SavePath .. 'meth_magic_config.txt'
MethMagic._config = {}

-- loads localized strings into in-game menu
Hooks:Add(
    'LocalizationManagerPostInit',
    'LocalizationManagerPostInit_MethMagic',
    function(loc)
        loc:load_localization_file(MethMagic._path .. 'menu/' .. 'blt_menu.json')
    end
) 

-- loads localized strings into in-game menu
Hooks:Add(
    'MenuManagerInitialize',
    'MenuManagerInitialize_MethMagic',
    function(menu_manager)
        -- loads saved config file
        MethMagic:LoadConfigFile()
        
        -- loads in-game menu
        MenuHelper:LoadFromJsonFile(MethMagic._path .. 'menu/settings_menu.json', MethMagic, MethMagic._config)

        -- set menu item callback
        MenuCallbackHandler.callback_meth_magic_enable = function(self, item)
            MethMagic._config.meth_magic_enable_value = item:value() == 'on'
            MethMagic._config.enabled_toggle = item:value()

            -- save config file
            MethMagic:SaveConfigFile()
        end
    end
)

function MethMagic:LoadConfigFile()
    local file = io.open(self._config_path, 'r')
    if file then
        for k, v in pairs(json.decode(file:read('*all')) or {}) do
            self._config[k] = v
        end
        file:close()
    else 
        -- default configs
        MethMagic._config.enabled_toggle = true
    end
end

function MethMagic:SaveConfigFile()
    local file = io.open(self._config_path, 'w+')
    if file then
        file:write(json.encode(self._config))
        file:close()
    end
end 
