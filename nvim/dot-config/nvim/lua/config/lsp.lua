local lsps = vim
  .iter(vim.fs.dir(vim.fn.stdpath 'config' .. '/lsp'))
  :map(function(file)
    return string.match(file, '(.+)%.lua$')
  end)
  :totable()

vim.lsp.enable(lsps)

--[[
-- Workaround for adding broder to snippet docs
-- until neovim natively supports 'previewpopup'
local function set_popup_border(winid)
  if winid and winid >= 0 and vim.api.nvim_win_is_valid(winid) then
    pcall(vim.api.nvim_win_set_config, winid, { border = 'rounded' })
  end
end

vim.api.nvim_create_autocmd('CompleteChanged', {
  group = vim.api.nvim_create_augroup('CompletionPopupBorder', { clear = true }),
  callback = function()
    vim.schedule(function()
      local info = vim.fn.complete_info { 'selected' }
      set_popup_border(info.preview_winid)
    end)
  end,
})

local overridden = vim.api.nvim__complete_set
---@diagnostic disable-next-line: duplicate-set-field
function vim.api.nvim__complete_set(index, opts)
  local windata = overridden(index, opts)
  set_popup_border(windata.winid)
  return windata
end
--]]

vim.filetype.add {
  pattern = {
    ['.*compose.*%.ya?ml'] = 'yaml.docker-compose',
  },
}

vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}
