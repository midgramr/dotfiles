return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    keys = {
      {
        '[c',
        function ()
          require('treesitter-context').go_to_context(vim.v.count1)
        end,
        mode = 'n',
        desc = 'Go to treesitter context',
        silent = true,
      }
    },
  },
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'editorconfig',
      'git_config',
      'go',
      'html',
      'java',
      'javascript',
      'json',
      'jsonc',
      'latex',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'properties',
      'python',
      'query',
      'regex',
      'toml',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    },
    highlight = {
      enable = true,
      disable = { 'latex' },
      additional_vim_regex_highlighting = { 'ruby' },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gi',
        scope_incremental = 'gi',
        node_decremental = 'go',
      },
    },
    indent = {
      enable = true,
      disable = { 'ruby', 'python' },
    },
  },
}
