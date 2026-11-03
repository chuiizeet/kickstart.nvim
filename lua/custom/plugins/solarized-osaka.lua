return {
  'craftzdog/solarized-osaka.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = 'dark'

    local transparency = require 'custom.transparency'

    local function load(transparent)
      require('solarized-osaka').setup {
        transparent = transparent,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          sidebars = transparent and 'transparent' or 'dark',
          floats = transparent and 'transparent' or 'dark',
        },
        -- on_colors = function(colors) end,      -- override colores
        -- on_highlights = function(hl, c) end,   -- override highlight groups
      }

      vim.cmd.colorscheme 'solarized-osaka'
    end

    -- <leader>bg / :Transparency recargan el tema por aquí
    transparency.setup { reload = load }
    load(transparency.enabled)
  end,
}
