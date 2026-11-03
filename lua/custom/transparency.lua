-- Fondo transparente: deja ver el fondo (o la imagen) de iTerm2.
-- El estado se guarda en disco, así sobrevive al reiniciar nvim.

local M = {}

local state_file = vim.fn.stdpath 'state' .. '/transparency'

M.enabled = (function()
  local ok, content = pcall(vim.fn.readfile, state_file)
  return ok and content[1] == '1'
end)()

-- Grupos que los temas/plugins pintan con su propio fondo y hay que limpiar a mano.
local groups = {
  -- core
  'Normal',
  'NormalNC',
  'NormalFloat',
  'FloatBorder',
  'FloatTitle',
  'SignColumn',
  'LineNr',
  'CursorLineNr',
  'FoldColumn',
  'EndOfBuffer',
  'MsgArea',
  'StatusLine',
  'StatusLineNC',
  'WinBar',
  'WinBarNC',
  'WinSeparator',
  'TabLine',
  'TabLineFill',
  -- neo-tree
  'NeoTreeNormal',
  'NeoTreeNormalNC',
  'NeoTreeEndOfBuffer',
  'NeoTreeWinSeparator',
  'NeoTreeStatusLine',
  'NeoTreeTabInactive',
  'NeoTreeTabSeparatorInactive',
  -- telescope
  'TelescopeNormal',
  'TelescopeBorder',
  'TelescopePromptNormal',
  'TelescopePromptBorder',
  'TelescopeResultsNormal',
  'TelescopePreviewNormal',
  -- bufferline
  'BufferLineFill',
  'BufferLineBackground',
  -- snacks / alpha / trouble / which-key / noice
  'SnacksNormal',
  'SnacksWinBar',
  'SnacksDashboardNormal',
  'AlphaHeader',
  'AlphaButtons',
  'AlphaFooter',
  'TroubleNormal',
  'TroubleNormalNC',
  'WhichKeyFloat',
  'WhichKeyNormal',
  'NoiceCmdlinePopup',
  'NoicePopup',
  'NoiceMini',
}

local function clear_backgrounds()
  for _, name in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    if ok and next(hl) ~= nil then
      hl.bg = nil
      hl.ctermbg = nil
      pcall(vim.api.nvim_set_hl, 0, name, hl)
    end
  end
end

-- Recarga el tema. El plugin del colorscheme puede registrar su propia versión
-- (vía M.setup) para usar la opción `transparent` nativa del tema.
M.reload = function()
  if vim.g.colors_name then
    vim.cmd.colorscheme(vim.g.colors_name)
  end
end

function M.setup(opts)
  if opts and opts.reload then
    M.reload = opts.reload
  end
end

function M.set(enabled)
  M.enabled = enabled
  pcall(vim.fn.writefile, { enabled and '1' or '0' }, state_file)
  M.reload(M.enabled)
end

function M.toggle()
  M.set(not M.enabled)
  vim.notify('Background: ' .. (M.enabled and 'transparent' or 'opaque'), vim.log.levels.INFO)
end

-- Después de cualquier cambio de colorscheme, volver a limpiar los fondos.
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('custom-transparency', { clear = true }),
  callback = function()
    if M.enabled then
      vim.schedule(clear_backgrounds)
    end
  end,
})

vim.api.nvim_create_user_command('Transparency', function(args)
  local arg = args.args
  if arg == 'on' then
    M.set(true)
  elseif arg == 'off' then
    M.set(false)
  else
    M.toggle()
  end
end, {
  nargs = '?',
  complete = function()
    return { 'on', 'off', 'toggle' }
  end,
  desc = 'Toggle transparent background (show iTerm2 background)',
})

vim.keymap.set('n', '<leader>bg', function()
  M.toggle()
end, { desc = 'Fondo transparente (ver iTerm2)' })

return M
