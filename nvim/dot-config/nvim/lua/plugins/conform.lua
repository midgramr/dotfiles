vim.pack.add({
  { src = vim.g.gh 'stevearc/conform.nvim', name = 'conform' },
}, { confirm = false })

local conform = require 'conform'
conform.setup {
  formatters_by_ft = {
    bash = { 'shfmt' },
    sh = { 'shfmt' },
    zsh = { 'shfmt' },

    c = { 'clang-format' },
    cpp = { 'clang-format' },

    tex = { 'tex-fmt' },

    lua = { 'stylua' },

    make = { 'bake' },

    ['_'] = { 'prettier' },
  },
  format_on_save = false,
}

vim.keymap.set('n', '<Leader>f', function()
  conform.format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })
