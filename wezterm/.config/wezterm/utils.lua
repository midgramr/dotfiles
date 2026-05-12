local wezterm = require 'wezterm'
local module = {}

function module.plugin(repo)
  return wezterm.plugin.require('https://github.com/' .. repo)
end

function module.add_keys(config, keys)
  if config.keys == nil then
    config.keys = {}
  end
  for _, mapping in ipairs(keys) do
    table.insert(config.keys, mapping)
  end
end

function module.apply_plugins(config)
  wezterm.log_info 'Sourcing plugins'
  local plugin_dir = wezterm.config_dir .. '/plugins'
  for _, file in ipairs(wezterm.read_dir(plugin_dir)) do
    local name = file:match '/(%w+)%.lua$'
    require('plugins.' .. name).apply_to_config(config)
  end
end

return module
