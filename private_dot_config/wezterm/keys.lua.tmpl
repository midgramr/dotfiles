---@type Wezterm
local wezterm = require 'wezterm'
local utils = require 'utils'
local module = {}

---Apply custom key bindings to global config
---@param config Config global config
function module.apply_to_config(config)
  local act = wezterm.action

  utils.add_keys(config, {
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
      key = 'r',
      mods = 'SUPER',
      action = act.ReloadConfiguration,
    },
    {
      key = 'w',
      mods = 'SUPER',
      action = act.CloseCurrentPane { confirm = false },
    },
    {
      key = 'w',
      mods = 'SUPER|SHIFT',
      action = act.CloseCurrentTab { confirm = false },
    },
    {
      key = 'x',
      mods = 'SUPER',
      action = act.ActivateCopyMode,
    },
    {
      key = '[',
      mods = 'SUPER',
      action = act.ScrollToPrompt(-1),
    },
    {
      key = ']',
      mods = 'SUPER',
      action = act.ScrollToPrompt(1),
    },
    {
      key = '\\',
      mods = 'META',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '-',
      mods = 'META',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
  })
  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'META',
      action = act.ActivateTab(i - 1),
    })
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'META|CTRL',
      action = act.MoveTab(i - 1),
    })
  end

  local search_mode = wezterm.gui.default_key_tables().search_mode
  table.insert(search_mode, {
    key = 'Enter',
    mods = 'NONE',
    action = act.CopyMode 'AcceptPattern',
  })
  table.insert(search_mode, { key = 'n', mods = 'META', action = act.CopyMode 'NextMatch' })
  table.insert(search_mode, { key = 'p', mods = 'META', action = act.CopyMode 'PriorMatch' })
  table.insert(search_mode, { key = 'u', mods = 'META', action = act.CopyMode 'ClearPattern' })

  local copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(copy_mode, {
    key = 'Escape',
    mods = 'NONE',
    action = act.Multiple {
      act.CopyMode 'ClearPattern',
      act.CopyMode 'ClearSelectionMode',
    },
  })
  table.insert(copy_mode, {
    key = '/',
    mods = 'NONE',
    action = act.Search 'CurrentSelectionOrEmptyString',
  })
  table.insert(copy_mode, {
    key = '?',
    mods = 'NONE',
    action = act.Search 'CurrentSelectionOrEmptyString',
  })
  table.insert(copy_mode, {
    key = 'i',
    mods = 'NONE',
    action = act.CopyMode 'Close',
  })

  config.key_tables = {
    search_mode = search_mode,
    copy_mode = copy_mode,
  }
end

return module
