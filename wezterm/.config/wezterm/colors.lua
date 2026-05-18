local module = {}

---Colorscheme colors
module.colors = {
  foreground = '#d4be98',
  background = '#282828',
  cursor_bg = '#d7be98',
  cursor_fg = '#282828',
  cursor_border = '#d7be98',
  selection_fg = '#282828',
  selection_bg = '#d8a657',
  scrollbar_thumb = '#928374',
  split = '#928374',
  ansi = {
    '#282828',
    '#ea6962',
    '#a9b665',
    '#d8a657',
    '#7daea3',
    '#d3869b',
    '#89b482',
    '#d4be98',
  },
  brights = {
    '#7c6f64',
    '#ea6962',
    '#a9b665',
    '#d8a657',
    '#7daea3',
    '#d3869b',
    '#89b482',
    '#ddc7a1',
  },
  compose_cursor = '#d8a657',
  tab_bar = {
    background = '#32302f',
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
