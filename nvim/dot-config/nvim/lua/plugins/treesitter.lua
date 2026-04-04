return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter'
    local parsers = {
      'bash',
      -- 'c',
      'cpp',
      'css',
      'diff',
      'dockerfile',
      'editorconfig',
      'git_config',
      'go',
      'html',
      'java',
      'javascript',
      'json',
      'jsx',
      'latex',
      -- 'lua',
      'luadoc',
      'make',
      -- 'markdown',
      -- 'markdown_inline',
      'properties',
      'python',
      'query',
      'regex',
      'tmux',
      'toml',
      'typescript',
      'tsx',
      'vim',
      -- 'vimdoc',
      'xml',
      'yaml',
      'zsh',
    }
    local patterns = vim.tbl_extend('force', parsers, {
      'javascriptreact',
      'typescriptreact',
      'yaml.docker-compose',
    })
    treesitter.install(parsers)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = patterns,
      callback = function()
        vim.treesitter.start()
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
