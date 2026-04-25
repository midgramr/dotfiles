vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
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

vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:TermCursor'

vim.o.fillchars = 'eob: '

vim.o.autochdir = true

vim.o.copyindent = true

vim.o.title = true

vim.o.tabline = '%!v:lua.MyTabline()'

-- TODO: come back to this later
function MyTabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr '$' do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local bufname = vim.fn.bufname(bufnr)

    local name = ''
    if vim.startswith(bufname, 'oil://') then
      local dirname = string.sub(bufname, 6, -2)
      name = vim.fn.fnamemodify(dirname, ':t')
    elseif bufname == '' then
      -- Are there any other situations in which the buffer wouldn't have a name?
      name = 'fzf'
    else
      name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
    end

    local tabfmt = '%s%%#%s# %d %s '
    if i == vim.fn.tabpagenr() then
      s = string.format(tabfmt, s, 'TabLineSel', i, name)
    else
      s = string.format(tabfmt, s, 'TabLine', i, name)
    end
  end
  return s .. '%#TabLineFill#'
end

require('vim._core.ui2').enable()
