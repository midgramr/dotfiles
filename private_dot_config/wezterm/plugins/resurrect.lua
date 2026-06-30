---@type Wezterm
local wezterm = require 'wezterm'
local utils = require 'utils'
local module = {}

local resurrect = utils.plugin 'MLFlexer/resurrect.wezterm'
resurrect.state_manager.periodic_save()

---Apply resurrect config to global config
---@param config Config global config
function module.apply_to_config(config)
  utils.add_keys(config, {
    {
      key = 's',
      mods = 'META',
      action = wezterm.action_callback(function()
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
      end),
    },
    {
      key = 'r',
      mods = 'META',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
          local type = string.match(id, '^([^/]+)')
          id = string.match(id, '([^/]+)$')
          id = string.match(id, '(.+)%..+$')
          local opts = {
            window = pane:window(),
            close_open_tabs = true,
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == 'workspace' then
            local state = resurrect.state_manager.load_state(id, 'workspace')
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == 'window' then
            local state = resurrect.state_manager.load_state(id, 'window')
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == 'tab' then
            local state = resurrect.state_manager.load_state(id, 'tab')
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
    },
  })
end

return module
