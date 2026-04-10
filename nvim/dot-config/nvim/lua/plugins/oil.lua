require('nvim-web-devicons').setup()
require('oil').setup {
    watch_for_changes = true,
    show_hidden = true,
    skip_confirm_for_simple_edits = true,
}

vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Open parent directory '})
