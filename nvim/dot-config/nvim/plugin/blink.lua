vim.pack.add({
  { src = utils.gh 'L3MON4D3/LuaSnip', version = 'v2.5.0', name = 'luasnip' },
  { src = utils.gh 'folke/lazydev.nvim', name = 'lazydev' },
  { src = utils.gh 'saghen/blink.cmp', version = 'v1.10.2' },
}, { confirm = false })

require('lazydev').setup()
require('luasnip').setup()
require('luasnip.loaders.from_snipmate').lazy_load()
require('blink.cmp').setup {
  keymap = {
    preset = 'none',
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'accept', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-l>'] = { 'snippet_forward', 'fallback_to_mappings' },
    ['<C-h>'] = { 'snippet_backward', 'fallback_to_mappings' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  cmdline = {
    keymap = {
      preset = 'inherit',
      ['<Tab>'] = { 'show_and_insert', 'accept', 'fallback' },
    },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      window = {
        winhighlight = 'Normal:Normal',
      },
    },
    ghost_text = { enabled = true },
    menu = {
      draw = {
        treesitter = { 'lsp' },
        components = {
          -- customize the drawing of kind icons
          kind_icon = {
            text = function(ctx)
              -- default kind icon
              local icon = ctx.kind_icon
              -- if LSP source, check for color derived from documentation
              if ctx.item.source_name == 'LSP' then
                local color_item = require('nvim-highlight-colors').format(
                  ctx.item.documentation,
                  { kind = ctx.kind }
                )
                if color_item and color_item.abbr ~= '' then
                  icon = color_item.abbr
                end
              end
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              -- default highlight group
              local highlight = 'BlinkCmpKind' .. ctx.kind
              -- if LSP source, check for color derived from documentation
              if ctx.item.source_name == 'LSP' then
                local color_item = require('nvim-highlight-colors').format(
                  ctx.item.documentation,
                  { kind = ctx.kind }
                )
                if color_item and color_item.abbr_hl_group then
                  highlight = color_item.abbr_hl_group
                end
              end
              return highlight
            end,
          },
        },
      },
      winhighlight = 'Normal:Normal,PmenuExtra:Normal,CursorLine:TelescopeSelection',
    },
  },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lazydev = {
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
}
