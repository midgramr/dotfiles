vim.pack.add({
  { src = vim.g.gh 'williamboman/mason.nvim', name = 'mason' },
  { src = vim.g.gh 'WhoIsSethDaniel/mason-tool-installer.nvim', name = 'mason-tool-installer' },
}, { confirm = false })

require('mason').setup()
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
    'mbake',
    'shfmt',
    'stylua',
    'tex-fmt',
  },
}
