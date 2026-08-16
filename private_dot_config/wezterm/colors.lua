local module = {}

---Colorscheme colors
module.colors = {
  foreground = '#d3c6aa',
  background = '#2d353b',
  cursor_bg = '#d3c6aa',
  cursor_fg = '#2d353b',
  cursor_border = '#d3c6aa',
  selection_fg = '#2d353b',
  selection_bg = '#a7c080',
  scrollbar_thumb = '#7a8478',
  split = '#7a8478',
  ansi = {
    '#2d353b',
    '#e67e80',
    '#a7c080',
    '#dbbc7f',
    '#7fbbb3',
    '#d699b6',
    '#83c092',
    '#d3c6aa',
  },
  brights = {
    '#7a8478',
    '#e67e80',
    '#a7c080',
    '#dbbc7f',
    '#7fbbb3',
    '#d699b6',
    '#83c092',
    '#d3c6aa',
  },
  compose_cursor = '#a7c080',
  tab_bar = {
    background = '#3d484d',
  },
}

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
