return {
  'rcarriga/nvim-notify',
  opts = {
    background_colour = '#262a40',
    stages = 'fade_in_slide_out',
    timeout = 3000,
    render = 'default',
    minimum_width = 30,
    icons = {
      ERROR = '',
      WARN = '',
      INFO = '',
      DEBUG = '',
      TRACE = '✎',
    },
  },
  config = function(_, opts)
    require('notify').setup(opts)

    -- Highlight groups (Tokyonight-inspired soft background)
    local hl = vim.api.nvim_set_hl
    local bg = '#262a40'
    hl(0, 'NotifyBackground', { bg = bg })
    hl(0, 'NotifyINFOBody', { fg = '#c0caf5', bg = bg })
    hl(0, 'NotifyWARNBody', { fg = '#e0af68', bg = bg })
    hl(0, 'NotifyERRORBody', { fg = '#f7768e', bg = bg })
    hl(0, 'NotifyDEBUGBody', { fg = '#9ece6a', bg = bg })
  end,
}
