local lsps = vim
  .iter(vim.fs.dir(vim.fn.stdpath 'config' .. '/lsp'))
  :filter(function(_, type)
    return type == 'file'
  end)
  :map(function(file)
    return string.match(file, '(.+)%.lua$')
  end)
  :totable()

vim.lsp.enable(lsps)

vim.filetype.add {
  pattern = {
    ['.*compose.*%.ya?ml'] = 'yaml.docker-compose',
  },
}

vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, {
  desc = 'vim.diagnostic.open_float',
})

vim.keymap.set('n', '<Leader>D', function()
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
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
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
