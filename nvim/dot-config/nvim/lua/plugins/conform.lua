return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      zsh = { 'shfmt' },

      cpp = { 'clang-format' },

      lua = { 'stylua' },

      ['_'] = { 'prettier' },
    },
    default_format_opts = { lsp_format = 'fallback' },
    format_on_save = false,
  },
}
