local wezterm = require 'wezterm'
local utils = require 'utils'
local module = {}

function module.apply_to_config(config)
  local act = wezterm.action
  if config.keys == nil then
    config.keys = {}
  end
  utils.extend(config.keys, {
    {
      key = 'k',
      mods = 'SUPER',
      action = act.ShowTabNavigator,
    },
    {
      key = 'l',
      mods = 'SUPER',
      action = act.ShowDebugOverlay,
    },
    {
      key = 'p',
      mods = 'SUPER',
      action = act.ActivateCommandPalette,
    },
    {
      key = 'w',
      mods = 'SUPER',
      action = act.CloseCurrentTab { confirm = false },
    },
    {
      key = 'x',
      mods = 'SUPER',
      action = act.ActivateCopyMode,
    },
  })
  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'META',
      action = act.ActivateTab(i - 1),
    })
  end
end

return module
