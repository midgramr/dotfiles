local utils = require 'utils'
local colors = require 'colors'
local module = {}

---@type TablineWez
local tabline = utils.plugin 'michaelbrusegard/tabline.wez'
tabline.setup {
  options = {
    theme = colors.colors,
    theme_overrides = {
      normal_mode = {
        a = { fg = '#171311', bg = '#a09384' },
        b = { fg = '#e6d5c2', bg = '#201b19' },
        c = { fg = '#e6d5c2', bg = '#201b19' },
        x = { fg = '#e6d5c2', bg = '#201b19' },
        y = { fg = '#e6d5c2', bg = '#362f2c' },
        z = { fg = '#171311', bg = '#a09384' },
      },
      copy_mode = {
        a = { fg = '#171311', bg = '#fcba81' },
        b = { fg = '#fcba81', bg = '#201b19' },
        c = { fg = '#fcba81', bg = '#201b19' },
        x = { fg = '#fcba81', bg = '#201b19' },
        y = { fg = '#fcba81', bg = '#362f2c' },
        z = { fg = '#171311', bg = '#fcba81' },
      },
      search_mode = {
        a = { fg = '#171311', bg = '#99af6b' },
        b = { fg = '#99af6b', bg = '#201b19' },
        c = { fg = '#99af6b', bg = '#201b19' },
        x = { fg = '#99af6b', bg = '#201b19' },
        y = { fg = '#99af6b', bg = '#362f2c' },
        z = { fg = '#171311', bg = '#99af6b' },
      },
      tab = {
        active = { fg = '#e6d5c2', bg = '#362f2c' },
        inactive = { fg = '#73665b', bg = '#201b19' },
        inactive_hover = { fg = '#e6d5c2', bg = '#2a2422' },
      },
    },
    section_separators = '',
    component_separators = '',
    tab_separators = '',
  },
  sections = {
    tab_active = { 'index', { 'process', padding = { left = 0, right = 1 } } },
    tabline_x = { '' },
    tabline_y = { '' },
  },
  extensions = { 'smart_workspace_switcher' },
}

---Apply tabline config to global config
---@param config Config global config
function module.apply_to_config(config)
  tabline.apply_to_config(config)
  config.tab_bar_at_bottom = true
end

return module
