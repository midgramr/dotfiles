vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.winborder = 'rounded'

vim.o.termguicolors = true

vim.opt.guicursor = { 'n-v-c-sm:block', 'i-ci-ve:ver25', 'r-cr-o:hor20', 't:TermCursor' }

vim.o.fillchars = 'eob: '

vim.o.copyindent = true

vim.o.title = true

vim.o.tabline = '%!v:lua.Tabline()'
