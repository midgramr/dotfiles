local colorschemes = {
  ['everforest'] = {
    'sainnhe/everforest',
    lazy = false,
    priority = 20000,
    config = function ()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_cursor = 'auto'
      vim.g.everforest_float_style = 'blend'
      vim.g.everforest_background = 'hard'
      vim.cmd.colorscheme 'everforest'
    end
  },

  ['gruvbox-material'] = {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 20000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_float_style = 'blend'
      vim.g.gruvbox_material_disable_terminal_colors = true
      vim.g.gruvbox_material_current_word = 'bold'
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  ['kanagawa-paper'] = {
    'thesimonho/kanagawa-paper.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa-paper'
    end,
  },
}

return colorschemes['gruvbox-material']
