require('vim._core.ui2').enable()

-- TODO: make this better
function Tabline()
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
