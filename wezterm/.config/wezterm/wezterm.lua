local wezterm = require 'wezterm'
local config = wezterm.config_builder()

require('colors').apply_to_config(config)
require('font').apply_to_config(config)
require('keys').apply_to_config(config)
require('tabline').apply_to_config(config)
require('workspace').apply_to_config(config)

config.term = 'wezterm'
config.window_close_confirmation = 'NeverPrompt'
config.window_content_alignment = {
  horizontal = 'Center',
  vertical = 'Center',
}
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font 'Overpass',
}
config.window_padding = {
  left = '2pt',
  right = '2pt',
  top = '0pt',
  bottom = '0pt',
}

-- TODO: update color for inactive cursor

return config
