-- Genera el preset de iTerm2 a partir del tema activo.
--
--   nvim --headless "+luafile iterm/generate.lua" +qa
--
-- Los 16 colores ANSI salen de `vim.g.terminal_color_*`, que es lo mismo que
-- usa el `:terminal` de Neovim (el colorscheme los define y
-- lua/custom/plugins/toggleterm.lua repara las degeneraciones). Así iTerm2 y
-- el terminal de dentro de nvim quedan idénticos por construcción.
--
-- Los colores de UI salen de los highlight groups reales, no de la paleta a
-- ojo, para que peguen con lo que se ve en el editor.

local function hl(name, part)
  local h = vim.api.nvim_get_hl(0, { name = name, link = false })
  return h[part] and string.format('#%06x', h[part]) or nil
end

local function components(hex)
  local r, g, b = tostring(hex):match '^#(%x%x)(%x%x)(%x%x)$'
  assert(r, 'color inválido: ' .. tostring(hex))
  return tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255
end

local function entry(key, hex, alpha)
  local r, g, b = components(hex)
  return table.concat({
    ('\t<key>%s</key>'):format(key),
    '\t<dict>',
    '\t\t<key>Alpha Component</key>',
    ('\t\t<real>%s</real>'):format(alpha or 1),
    '\t\t<key>Blue Component</key>',
    ('\t\t<real>%.16f</real>'):format(b),
    '\t\t<key>Color Space</key>',
    '\t\t<string>sRGB</string>',
    '\t\t<key>Green Component</key>',
    ('\t\t<real>%.16f</real>'):format(g),
    '\t\t<key>Red Component</key>',
    ('\t\t<real>%.16f</real>'):format(r),
    '\t</dict>',
  }, '\n')
end

local bg = hl('Normal', 'bg') or vim.g.terminal_color_0
local fg = hl('Normal', 'fg')
local cursor_bg = hl('Cursor', 'bg') or fg
local cursor_fg = hl('Cursor', 'fg') or bg
local visual_bg = hl('Visual', 'bg')
local cursorline_bg = hl('CursorLine', 'bg') or visual_bg

-- iTerm2 ordena las claves alfabéticamente: Ansi 0, Ansi 1, Ansi 10, Ansi 11...
local ansi_order = { 0, 1, 10, 11, 12, 13, 14, 15, 2, 3, 4, 5, 6, 7, 8, 9 }

local parts = {}
for _, i in ipairs(ansi_order) do
  local color = vim.g['terminal_color_' .. i]
  assert(color, 'falta terminal_color_' .. i .. ' (el colorscheme no los define?)')
  table.insert(parts, entry(('Ansi %d Color'):format(i), color))
end

table.insert(parts, entry('Background Color', bg))
table.insert(parts, entry('Badge Color', vim.g.terminal_color_1, 0.5))
table.insert(parts, entry('Bold Color', vim.g.terminal_color_15))
table.insert(parts, entry('Cursor Color', cursor_bg))
table.insert(parts, entry('Cursor Guide Color', cursorline_bg, 0.25))
table.insert(parts, entry('Cursor Text Color', cursor_fg))
table.insert(parts, entry('Foreground Color', fg))
table.insert(parts, entry('Link Color', vim.g.terminal_color_4))
table.insert(parts, entry('Selected Text Color', fg))
table.insert(parts, entry('Selection Color', visual_bg))

local plist = table.concat({
  '<?xml version="1.0" encoding="UTF-8"?>',
  '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
  '<plist version="1.0">',
  '<dict>',
  table.concat(parts, '\n'),
  '</dict>',
  '</plist>',
  '',
}, '\n')

local name = vim.g.colors_name or 'theme'
local out = vim.fs.joinpath(vim.fn.stdpath 'config', 'iterm', name .. '-' .. vim.o.background .. '.itermcolors')
local fd = assert(io.open(out, 'w'))
fd:write(plist)
fd:close()
print('escrito: ' .. out)
