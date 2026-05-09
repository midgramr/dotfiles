local wezterm = require 'wezterm'
local module = {}

function module.plugin(repo)
  return wezterm.plugin.require('https://github.com/' .. repo)
end

function module.extend(list1, list2)
  wezterm.log_info(list1)
  for _, v in ipairs(list2) do
    wezterm.log_info(v)
    table.insert(list1, v)
  end
end

return module
