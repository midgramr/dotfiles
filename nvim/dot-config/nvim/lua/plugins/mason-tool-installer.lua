return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
  },
  config = function()
    require('mason-tool-installer').setup {
      auto_update = true,
      ensure_installed = {
        -- language servers
        'bash-language-server',
        'clangd',
        'css-lsp',
        'docker-compose-language-service',
        'docker-language-server',
        'eslint-lsp',
        'gh-actions-language-server',
        'gopls',
        'html-lsp',
        'jdtls',
        'json-lsp',
        'lua-language-server',
        'marksman',
        'pyright',
        'texlab',
        'typescript-language-server',

        -- formatters
        'clang-format',
        'shfmt',
        'stylua',
        'tex-fmt',
      },
    }
  end,
}
