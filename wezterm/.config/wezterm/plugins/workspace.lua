local utils = require 'utils'
local module = {}

---@type SWS
local workspace_switcher = utils.plugin 'MLFlexer/smart_workspace_switcher.wezterm'
workspace_switcher.zoxide_path = '/opt/homebrew/bin/zoxide'

---Apply workspace switcher config to global config
---@param config Config global config
function module.apply_to_config(config)
  utils.add_keys(config, {
    {
      key = 'f',
      mods = 'META',
      action = workspace_switcher.switch_workspace(),
    },
    {
      key = 'Tab',
      mods = 'META',
      action = workspace_switcher.switch_to_prev_workspace(),
    },
  })
end

return module
