return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup()

    function Get_lsp_client()
      local clients = vim.lsp.get_clients()
      local names = ''
      local seen = {}
      for i = 1, #clients do
        local name = clients[i]['name']
        if not seen[name] then
          names = names .. ', ' .. name
          seen[name] = true
        end
      end
      return names
    end

    local statusline = require 'mini.statusline'
    statusline.setup {
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode { trunc_width = 100 }
          local filename = statusline.section_filename { trunc_width = 999 }
          local fileinfo = statusline.section_fileinfo { trunc_width = 999 }
          return statusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { strings = { '%{v:lua.Get_lsp_client()}' } },
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { '%2l:%-2c' } },
          }
        end,
      },
    }

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
