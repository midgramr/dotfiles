local utils = require 'utils'
local module = {}

local smart_splits = utils.plugin 'mrjones2014/smart-splits.nvim'

function module.apply_to_config(config)
  smart_splits.apply_to_config(config, {
    direction_keys = { 'h', 'j', 'k', 'l' },
    modifiers = {
      move = 'META',
      resize = 'META|SHIFT',
    },
    log_level = 'info',
  })
end

return module
