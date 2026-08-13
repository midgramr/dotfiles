vim.pack.add {
  { src = 'https://github.com/scalameta/nvim-metals' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' }, -- required dep
}

local ft = { 'scala', 'sbt', 'java' }

local metals_config = require('metals').bare_config()
metals_config.init_options.statusBarProvider = 'off'
metals_config.settings = {
  serverVersion = '2.0.0-M2',
  serverProperties = { '-Xmx8g' },
}

local group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = ft,
  group = group,
  callback = function()
    vim.env.JAVA_HOME = vim.fn.expand('/opt/homebrew/CEllar/openjdk@21/21.0.12')
    vim.opt_global.shortmess:remove 'F'
    require('metals').initialize_or_attach(metals_config)
  end,
})
