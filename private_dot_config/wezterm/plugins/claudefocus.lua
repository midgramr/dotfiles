---@type Wezterm
local wezterm = require 'wezterm'
local module = {}

local function find_pane(pane_id)
  for _, win in ipairs(wezterm.mux.all_windows()) do
    for _, tab in ipairs(win:tabs()) do
      for _, pane in ipairs(tab:panes()) do
        if pane:pane_id() == pane_id then
          return win, tab, pane
        end
      end
    end
  end
end

-- user-var-changed only fires for panes in the active workspace, so the value
-- carries the id of the pane to focus rather than relying on the emitting pane
wezterm.on('user-var-changed', function(_, _, name, value)
  if name ~= 'claude_focus' then
    return
  end

  local ok, err = pcall(function()
    local win, tab, pane = find_pane(tonumber(value))
    if not pane then
      return
    end

    if wezterm.mux.get_active_workspace() ~= win:get_workspace() then
      wezterm.mux.set_active_workspace(win:get_workspace())
    end

    tab:activate()
    pane:activate()

    local gui = win:gui_window()
    if gui then
      gui:focus()
    end
  end)

  if not ok then
    wezterm.log_error('claudefocus: ' .. tostring(err))
  end
end)

function module.apply_to_config(config) end

return module
