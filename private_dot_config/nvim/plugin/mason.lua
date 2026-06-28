vim.pack.add({
  { src = utils.gh 'williamboman/mason.nvim', name = 'mason' },
  {
    src = utils.gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
    name = 'mason-tool-installer',
  },
}, { confirm = false })

require('mason').setup()
require('mason-tool-installer').setup {
  auto_update = true,
  ensure_installed = {
    -- language servers
    'bash-language-server',
    'clangd',
    'docker-compose-language-service',
    'docker-language-server',
    'eslint-lsp',
    'fish-lsp',
    'html-lsp',
    'jdtls',
    'json-lsp',
    'lua-language-server',
    'marksman',
    'pyright',
    'typescript-language-server',

    -- formatters
    'clang-format',
    'gersemi',
    'mbake',
    'shfmt',
    'stylua',
    'tex-fmt',
  },
}
