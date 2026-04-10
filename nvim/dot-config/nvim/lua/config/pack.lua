local gh = function(x)
  return 'https://github.com/' .. x
end

vim.api.nvim_create_user_command('PackList', function()
  vim.pack.update(nil, { offline = true })
end, { desc = 'List installed packages' })

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'List installed packages' })

vim.api.nvim_create_user_command('PackPrune', function()
  local nonactive = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()
  vim.pack.del(nonactive)
end, { desc = 'Prune unused packages' })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end,
})

-- Builtin plugins
vim.cmd.packadd 'nvim.difftool'
vim.cmd.packadd 'nvim.tohtml'
vim.cmd.packadd 'nvim.undotree'

-- Downloaded plugins
vim.pack.add({
  { src = gh 'saghen/blink.cmp', version = 'v1.10.2' },
  { src = gh 'stevearc/conform.nvim', name = 'conform' },
  { src = gh 'lewis6991/gitsigns.nvim', name = 'gitsigns' },
  { src = gh 'sainnhe/gruvbox-material' },
  { src = gh 'L3MON4D3/LuaSnip', version = 'v2.5.0', name = 'luasnip' },
  { src = gh 'folke/lazydev.nvim', name = 'lazydev' },
  { src = gh 'williamboman/mason.nvim', name = 'mason' },
  { src = gh 'WhoIsSethDaniel/mason-tool-installer.nvim', name = 'mason-tool-installer' },
  { src = gh 'windwp/nvim-autopairs' },
  { src = gh 'nvim-tree/nvim-web-devicons' },
  { src = gh 'brenoprata10/nvim-highlight-colors' },
  { src = gh 'stevearc/oil.nvim', name = 'oil' },
  { src = gh 'nvim-lua/plenary.nvim', name = 'plenary' },
  { src = gh 'nvim-telescope/telescope.nvim', name = 'telescope', version = 'v0.2.0' },
  { src = gh 'nvim-telescope/telescope-fzf-native.nvim', name ='telescope-fzf-native' },
  { src = gh 'nvim-telescope/telescope-ui-select.nvim', name = 'telescope-ui-select' },
  { src = gh 'folke/todo-comments.nvim', name = 'todo-comments' },
  { src = gh 'nvim-treesitter/nvim-treesitter' },
  { src = gh 'aserowy/tmux.nvim', name = 'tmux' },
  { src = gh 'lervag/vimtex' },
}, { confirm = false })

-- TODO: better to iterate through files in plugin dir and require them, rather than
-- specifying them individually here
require 'plugins.autopairs'
require 'plugins.blink'
require 'plugins.conform'
require 'plugins.gitsigns'
require 'plugins.gruvbox-material'
require 'plugins.mason-tool-installer'
require 'plugins.nvim-highlight-colors'
require 'plugins.nvim-treesitter'
require 'plugins.oil'
require 'plugins.telescope'
require 'plugins.tmux'
require 'plugins.todo-comments'
require 'plugins.vimtex'
