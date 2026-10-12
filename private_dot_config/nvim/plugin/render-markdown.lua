vim.pack.add({
  { src = utils.gh 'MeanderingProgrammer/render-markdown.nvim' },
}, { confirm = false })

local icons = require 'render-markdown.lib.icons'
local palette = { 'Red', 'Orange', 'Yellow', 'Green', 'Aqua', 'Blue', 'Purple' }

local function hue_channels(rgb)
  local channels = { math.floor(rgb / 65536), math.floor(rgb / 256) % 256, rgb % 256 }
  local low, high = math.min(unpack(channels)), math.max(unpack(channels))
  for i = 1, 3 do
    channels[i] = high == low and 0 or (channels[i] - low) / (high - low)
  end
  return channels, high - low
end

icons.get = function(language)
  local filetype = vim.filetype.match({ filename = 'a.' .. language }) or language
  local icon, color = require('nvim-web-devicons').get_icon_color_by_filetype(filetype)
  if not color then
    return icon, 'Fg'
  end

  local channels, chroma = hue_channels(tonumber(color:sub(2), 16))
  if chroma < 30 then
    return icon, 'Grey'
  end

  local closest, distance = 'Fg', math.huge
  for _, group in ipairs(palette) do
    local fg = vim.api.nvim_get_hl(0, { name = group, link = false }).fg
    if fg then
      local candidate = hue_channels(fg)
      local delta = 0
      for i = 1, 3 do
        delta = delta + (channels[i] - candidate[i]) ^ 2
      end
      if delta < distance then
        closest, distance = group, delta
      end
    end
  end
  return icon, closest
end

require('render-markdown').setup()

vim.keymap.set('n', '<Leader>m', '<Cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown rendering' })
