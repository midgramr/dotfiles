local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'
local actions = require 'telescope.actions'

local git_commit_opts = {
  mappings = {
    i = {
      ['<C-v>'] = false,
      ['<C-x>'] = false,
      ['<C-t>'] = false,
      ['<CR>'] = 'select_vertical',
    },
  },
}

telescope.setup {
  defaults = {
    sorting_strategy = 'ascending',

    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        prompt_position = 'top',
        width = { 0.95, max = 120 },
        preview_height = 0.7,
      },
    },

    dynamic_preview_title = true,
    preview = {
      check_mime_type = false,
      filesize_limit = false,
      highlight_limit = false,
      timeout = false,
    },

    mappings = {
      i = {
        ['<M-f>'] = false,
        ['<M-k>'] = false,

        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<C-h>'] = 'results_scrolling_left',
        ['<C-l>'] = 'results_scrolling_right',
        ['<C-b>'] = 'preview_scrolling_left',
        ['<C-f>'] = 'preview_scrolling_right',
        ['<C-r>'] = 'to_fuzzy_refine',
        ['<C-Down>'] = actions.cycle_history_next,
        ['<C-Up>'] = actions.cycle_history_prev,
      },
    },
  },

  pickers = {
    colorscheme = { enable_preview = true },
    git_bcommits = git_commit_opts,
    git_bcommits_range = git_commit_opts,
  },

  extensions = {
    ['ui-select'] = {
      themes.get_dropdown(),
    },
  },
}

-- Enable Telescope extensions if they are installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

-- General
vim.keymap.set('n', '<Leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<Leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<Leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<Leader>st', builtin.builtin, { desc = '[S]earch [T]elescope' })
vim.keymap.set('n', '<Leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<Leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<Leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<Leader>sR', builtin.registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<Leader>sj', builtin.jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<Leader>so', builtin.vim_options, { desc = '[S]earch [O]ptions' })
vim.keymap.set('n', '<Leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<Leader>/', function()
  builtin.current_buffer_fuzzy_find()
end, { desc = '[/] Fuzzy search in current buffer' })
vim.keymap.set('n', '<Leader>sH', builtin.highlights, { desc = '[S]earch [H]ighlights' })
vim.keymap.set('n', '<Leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<Leader>sb', builtin.buffers, { desc = '[S]earch [M]arks' })

-- Map common functions to easier keybinds
vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = 'Search files' })

-- LSP overrides
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.keymap.set('n', '<Leader>q', function()
      builtin.diagnostics { bufnr = 0 }
    end, { desc = 'Diagnostics; overrides vim.diagnostic.setloclist()' })
    vim.keymap.set('n', 'grr', builtin.lsp_references, {
      desc = 'LSP references; overrides vim.lsp.buf.references()',
    })
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, {
      desc = 'LSP definition; overrides vim.lsp.buf.definition()',
    })
    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, {
      desc = 'LSP document symbols; overrides vim.lsp.buf.document_symbol()',
    })
    vim.keymap.set('n', '<Leader>O', builtin.lsp_workspace_symbols, {
      desc = 'LSP workspace symbols',
    })
  end,
})

-- Git
vim.keymap.set('n', '<Leader>gh', builtin.git_bcommits, { desc = '[G]it buffer commit [H]istory' })
vim.keymap.set('v', '<Leader>gh', builtin.git_bcommits_range, { desc = '[G]it buffer commit [H]istory' })
