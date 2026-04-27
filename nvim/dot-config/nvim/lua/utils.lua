local M = {}

---Helper to convert "owner/repo" string to GitHub URL
---@param repo string
---@return string url
function M.gh(repo)
  return 'https://github.com/' .. repo
end

---Is the popup menu visible?
---@return boolean
function M.pumvisible()
  return vim.fn.pumvisible() ~= 0
end

---My config's util functions
_G.utils = M
