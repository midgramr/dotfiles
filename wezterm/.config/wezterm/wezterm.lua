local wezterm = require 'wezterm'
local config = wezterm.config_builder()

require('colors').apply_to_config(config)
require('font').apply_to_config(config)
require('keys').apply_to_config(config)
require('plugins.splits').apply_to_config(config)
require('plugins.tabline').apply_to_config(config)
require('plugins.workspace').apply_to_config(config)

config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
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

return config
