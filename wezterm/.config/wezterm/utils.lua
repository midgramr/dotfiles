local wezterm = require 'wezterm'
local module = {}

function module.plugin(repo)
  return wezterm.plugin.require('https://github.com/' .. repo)
end

function module.addkeys(config, keys)
  if config.keys == nil then
    config.keys = {}
  end
  for _, v in ipairs(keys) do
    wezterm.log_info(v)
    table.insert(config.keys, v)
  end
end

return module
