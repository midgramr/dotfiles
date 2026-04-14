vim.pack.add({
  { src = vim.g.gh 'nvim-treesitter/nvim-treesitter' },
}, { confirm = false })

require('nvim-treesitter').install {
  'bash',
  'c',
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
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'properties',
  'python',
  'query',
  'regex',
  'tmux',
  'toml',
  'typescript',
  'tsx',
  'vim',
  'xml',
  'yaml',
  'zsh',
}
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start()
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo.foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
