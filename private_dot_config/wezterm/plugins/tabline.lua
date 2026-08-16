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
        a = { fg = '#2d353b', bg = '#a89984' },
        b = { fg = '#d3c6aa', bg = '#343f44' },
        c = { fg = '#d3c6aa', bg = '#343f44' },
        x = { fg = '#d3c6aa', bg = '#343f44' },
        y = { fg = '#d3c6aa', bg = '#56635f' },
        z = { fg = '#2d353b', bg = '#a89984' },
      },
      copy_mode = {
        a = { fg = '#2d353b', bg = '#dbbc7f' },
        b = { fg = '#dbbc7f', bg = '#343f44' },
        c = { fg = '#dbbc7f', bg = '#343f44' },
        x = { fg = '#dbbc7f', bg = '#343f44' },
        y = { fg = '#dbbc7f', bg = '#56635f' },
        z = { fg = '#2d353b', bg = '#dbbc7f' },
      },
      search_mode = {
        a = { fg = '#2d353b', bg = '#a7c080' },
        b = { fg = '#a7c080', bg = '#343f44' },
        c = { fg = '#a7c080', bg = '#343f44' },
        x = { fg = '#a7c080', bg = '#343f44' },
        y = { fg = '#a7c080', bg = '#56635f' },
        z = { fg = '#2d353b', bg = '#a7c080' },
      },
      tab = {
        active = { fg = '#d3c6aa', bg = '#56635f' },
        inactive = { fg = '#7a8478', bg = '#343f44' },
        inactive_hover = { fg = '#d3c6aa', bg = '#3d484d' },
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
