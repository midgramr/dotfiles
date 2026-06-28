---@type vim.lsp.Config
return {
  cmd = {
    vim.fn.stdpath 'data' .. '/mason/bin/clangd',
    '--clang-tidy',
    '--background-index',
    '--query-driver=/opt/homebrew/bin/g++-15,/opt/homebrew/bin/gcc-15',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    '.git',
  },
}
