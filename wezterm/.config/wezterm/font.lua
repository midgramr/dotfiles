local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Medium' })
  config.font_size = 13
  config.char_select_font_size = 14
  config.command_palette_font_size = 14
  config.command_palette_rows = 14
end

return module
