return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
  },
  config = function()
    local servers = require 'config.lsp.servers'
    local ensure_installed = servers
    -- TODO: make separate module for formatters/linters
    vim.list_extend(ensure_installed, {
      'clang-format',
      'html-lsp',
      'stylua',
    })
    require('mason-tool-installer').setup {
      auto_update = true,
      ensure_installed = ensure_installed,
    }
  end,
}
