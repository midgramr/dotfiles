vim.pack.add({
  { src = utils.gh 'MeanderingProgrammer/render-markdown.nvim' },
}, { confirm = false })

require('render-markdown').setup()

-- Heading text uses everforest's markdownH1..H6 colors (red, orange, yellow,
-- green, blue, purple). Match each heading background to its text color using
-- the muted 'bg_*' palette entry where one exists, blending the accent into the
-- background otherwise (everforest has no 'bg_orange').
local heading_accents = { 'red', 'orange', 'yellow', 'green', 'blue', 'purple' }

local function everforest_palette()
  local ok, palette = pcall(
    vim.fn['everforest#get_palette'],
    vim.g.everforest_background or 'medium',
    vim.g.everforest_colors_override or vim.empty_dict()
  )
  if ok and type(palette) == 'table' and palette.bg0 then
    return palette
  end
end

local function blend(foreground, background, alpha)
  local function channels(hex)
    return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
  end
  local fr, fg, fb = channels(foreground)
  local br, bg, bb = channels(background)
  return ('#%02x%02x%02x'):format(
    math.floor(fr * alpha + br * (1 - alpha)),
    math.floor(fg * alpha + bg * (1 - alpha)),
    math.floor(fb * alpha + bb * (1 - alpha))
  )
end

local function apply_heading_backgrounds()
  if vim.g.colors_name ~= 'everforest' then
    return
  end
  local palette = everforest_palette()
  if not palette then
    return
  end
  for level, accent in ipairs(heading_accents) do
    local muted = palette['bg_' .. accent] and palette['bg_' .. accent][1]
      or blend(palette[accent][1], palette.bg0[1], 0.16)
    vim.api.nvim_set_hl(0, ('RenderMarkdownH%dBg'):format(level), { bg = muted })
  end
end

apply_heading_backgrounds()
vim.api.nvim_create_autocmd('ColorScheme', { callback = apply_heading_backgrounds })

vim.keymap.set('n', '<Leader>m', '<Cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown rendering' })
