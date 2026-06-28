---@type Wezterm
local wezterm = require 'wezterm'
---@type Config
local config = wezterm.config_builder()
local utils = require 'utils'

require('colors').apply_to_config(config)
require('font').apply_to_config(config)
require('keys').apply_to_config(config)
utils.apply_plugins(config)

config.default_prog = { 'fish', '-l' }
config.term = 'wezterm'
config.use_ime = false
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font 'Overpass',
}
config.window_padding = {
  left = '8pt',
  right = '6pt',
  top = '10pt',
  bottom = '10pt',
}

return config
