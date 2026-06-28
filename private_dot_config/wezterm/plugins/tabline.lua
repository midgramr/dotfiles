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
        a = { fg = '#282828', bg = '#a89984' },
        b = { fg = '#ddc7a1', bg = '#32302f' },
        c = { fg = '#ddc7a1', bg = '#32302f' },
        x = { fg = '#ddc7a1', bg = '#32302f' },
        y = { fg = '#ddc7a1', bg = '#504945' },
        z = { fg = '#282828', bg = '#a89984' },
      },
      copy_mode = {
        a = { fg = '#282828', bg = '#d8a657' },
        b = { fg = '#d8a657', bg = '#32302f' },
        c = { fg = '#d8a657', bg = '#32302f' },
        x = { fg = '#d8a657', bg = '#32302f' },
        y = { fg = '#d8a657', bg = '#504945' },
        z = { fg = '#282828', bg = '#d8a657' },
      },
      search_mode = {
        a = { fg = '#282828', bg = '#a9b665' },
        b = { fg = '#a9b665', bg = '#32302f' },
        c = { fg = '#a9b665', bg = '#32302f' },
        x = { fg = '#a9b665', bg = '#32302f' },
        y = { fg = '#a9b665', bg = '#504945' },
        z = { fg = '#282828', bg = '#a9b665' },
      },
      tab = {
        active = { fg = '#ddc7a1', bg = '#504945' },
        inactive = { fg = '#928374', bg = '#32302f' },
        inactive_hover = { fg = '#ddc7a1', bg = '#3a3735' },
      },
    },
    section_separators = '',
    component_separators = '',
    tab_separators = '',
  },
  sections = {
    tab_active = { 'index', { 'process', padding = { left = 0, right = 1 } } },
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
