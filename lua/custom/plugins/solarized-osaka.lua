return {
  'craftzdog/solarized-osaka.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = 'dark'

    require('solarized-osaka').setup {
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
      -- on_colors = function(colors) end,      -- override colores
      -- on_highlights = function(hl, c) end,   -- override highlight groups
    }

    vim.cmd.colorscheme 'solarized-osaka'
  end,
}
