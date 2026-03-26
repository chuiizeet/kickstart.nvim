-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  -- init = function()
  --   -- Load neo-tree early when opening a directory
  --   vim.api.nvim_create_autocmd('BufEnter', {
  --     once = true,
  --     callback = function(args)
  --       if vim.fn.isdirectory(vim.fn.expand '%:p') == 1 then
  --         require 'neo-tree'
  --       end
  --     end,
  --   })
  -- end,
  opts = {
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_by_pattern = {
          '*.gd.uid',
        },
        never_show = {
          'node_modules',
          '.git',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
