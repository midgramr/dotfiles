local wezterm = require 'wezterm'
local utils = require 'utils'
local module = {}

local resurrect = utils.plugin 'MLFlexer/resurrect.wezterm'

resurrect.state_manager.periodic_save()

-- loads the state whenever I create a new workspace
wezterm.on('smart_workspace_switcher.workspace_switcher.created', function(window, _, label)
  local workspace_state = resurrect.workspace_state

  workspace_state.restore_workspace(resurrect.state_manager.load_state(label, 'workspace'), {
    window = window,
    relative = true,
    restore_text = true,
    on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  })
end)

-- Saves the state whenever I select a workspace
wezterm.on('smart_workspace_switcher.workspace_switcher.selected', function()
  local workspace_state = resurrect.workspace_state
  resurrect.state_manager.save_state(workspace_state.get_workspace_state())
end)

function module.apply_to_config(config)
  utils.add_keys(config, {
    {
      key = 'w',
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
