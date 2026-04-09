local lsps = {
  'bashls',
  'clangd',
  'cssls',
  'composels',
  'dockerls',
  'eslintls',
  'gh-actions-ls',
  'gopls',
  'html-ls',
  'jdtls',
  'jsonls',
  'luals',
  'marksman',
  'pyright',
  'texlab',
  'tsls',
}
vim.lsp.enable(lsps)

vim.filetype.add {
  filename = {
    ['compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
  },
}

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {
  desc = 'vim.diagnostic.open_float',
})
vim.keymap.set('n', '<leader>D', function()
  local enabled = vim.diagnostic.is_enabled { bufnr = 0 }
  vim.diagnostic.enable(not enabled, { bufnr = 0 })
end, {
  desc = 'Toggle LSP diagnostics',
})

vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}
