---@type vim.lsp.Config
return {
  cmd = { 'groovy-language-server' },
  filetypes = { 'groovy' },
  root_markers = { 'Jenkinsfile', '.git' },
}
