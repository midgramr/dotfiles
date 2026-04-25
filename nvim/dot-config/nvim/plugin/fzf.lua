vim.pack.add({
  { src = Gh 'ibhagwan/fzf-lua' },
  { src = Gh 'nvim-tree/nvim-web-devicons' },
}, { confirm = false })

require('fzf-lua').setup {
  { 'telescope', 'hide' },
  fzf_opts = {
    ['--layout'] = 'reverse',
  },
  ---@diagnostic disable-next-line: missing-fields
  hls = {
    header_text = 'Red',
    path_colnr = 'Blue',
    path_linenr = 'Green',
    buf_flag_cur = 'Red',
    buf_flag_alt = 'Blue',
    tab_title = 'Blue',
    tab_marker = 'ModeMsg',
    live_prompt = 'Purple',
    live_sym = 'Purple',
  },
  files = {
    formatter = 'path.filename_first',
    cwd_header = true,
    cwd_prompt = false,
  },
  zoxide = {
    scope = 'win',
  },
}

-- Buffers/files
vim.keymap.set('n', '<C-k>', FzfLua.builtin, { desc = 'fzf builtin' })
vim.keymap.set('n', '<C-f>', FzfLua.files, { desc = 'fzf files' })
vim.keymap.set('n', '<Leader>h', FzfLua.history, { desc = 'fzf history' })
vim.keymap.set('n', '<Leader>/', FzfLua.blines, { desc = 'fzf blines' })

-- Grep
vim.keymap.set('n', '<C-l>', FzfLua.live_grep, { desc = 'fzf live_grep' })

-- Git
vim.keymap.set('n', '<Leader>gc', FzfLua.git_bcommits, { desc = 'fzf bcommits' })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Setup fzf-lua lsp keymaps',
  callback = function()
    vim.keymap.set('n', 'grr', FzfLua.lsp_references, { desc = 'fzf lsp_references' })
    vim.keymap.set('n', 'gd', FzfLua.lsp_definitions, { desc = 'fzf lsp_definitions' })
    vim.keymap.set('n', 'gO', FzfLua.lsp_document_symbols, { desc = 'fzf lsp_document_symbols' })
    vim.keymap.set(
      'n',
      'gq',
      FzfLua.lsp_document_diagnostics,
      { desc = 'fzf lsp_document_diagnostics' }
    )
  end,
})

-- Misc
vim.keymap.set('n', '<Leader>r', FzfLua.resume, { desc = 'fzf resume' })
vim.keymap.set('n', '<Leader>o', FzfLua.nvim_options, { desc = 'fzf nvim_options' })
vim.keymap.set('n', '<C-h>', FzfLua.help_tags, { desc = 'fzf help_tags' })
vim.keymap.set('n', '<C-m>', FzfLua.man_pages, { desc = 'fzf man_pages' })
vim.keymap.set('n', '<C-z>', FzfLua.zoxide, { desc = 'fzf zoxide' })

FzfLua.register_ui_select()
