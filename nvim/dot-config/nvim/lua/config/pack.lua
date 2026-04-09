local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'windwp/nvim-autopairs',
  gh 'L3MON4D3/LuaSnip',
  gh 'saghen/blink.cmp',
  gh 'sainnhe/gruvbox-material',
  gh 'stevearc/conform.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'williamboman/mason.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'echasnovski/mini.nvim',
  gh 'brenoprata10/nvim-highlight-colors',
  gh 'stevearc/oil.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'aserowy/tmux.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'lervag/vimtex',
}
