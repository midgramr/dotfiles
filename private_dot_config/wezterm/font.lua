---@type Wezterm
local wezterm = require 'wezterm'
local module = {}

---Apply font configs to global config
---@param config Config global config
function module.apply_to_config(config)
  config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Medium' })
  config.font_size = 12
  config.char_select_font_size = 13
  config.command_palette_font_size = 13
  config.command_palette_rows = 13
end

return module
