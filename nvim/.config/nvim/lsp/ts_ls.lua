---@type vim.lsp.Config
return {
  init_options = {
    hostInfo = 'neovim',
    preferences = {
      importModuleSpecifierEnding = 'minimal',
      preferTypeOnlyAutoImports = true,
    },
  },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action {
        context = {
          only = source_actions,
          diagnostics = {},
        },
      }
    end, {})
    vim.keymap.set('n', 'grl', '<Cmd>LspTypescriptSourceAction<CR>', {
      desc = 'LspTypescriptSourceAction',
    })
  end,
  settings = {
    typescript = {
      format = {
        indentSize = 2,
        semicolons = 'insert',
        trimTrailingWhitespace = true,
      },
    },
  },
}
