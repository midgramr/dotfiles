local wezterm = require 'wezterm'
local module = {}

---Colorscheme colors
module.colors = wezterm.color.load_scheme(wezterm.config_dir .. '/colors/cendre.toml')

---Apply colors to global config
---@param config Config global config
function module.apply_to_config(config)
  config.colors = module.colors
  config.char_select_bg_color = module.colors.tab_bar.background
  config.char_select_fg_color = module.colors.foreground
  config.command_palette_bg_color = module.colors.tab_bar.background
  config.command_palette_fg_color = module.colors.foreground
  config.front_end = 'WebGpu'
end

return module
