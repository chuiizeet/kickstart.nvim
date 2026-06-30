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
    {
      '\\',
      function()
        require('neo-tree.command').execute { action = 'focus' }
      end,
      desc = 'NeoTree reveal & focus',
    },
  },
  -- Si nvim se abre con un directorio (ej: `nvim .`), forzar carga de neo-tree
  -- para que su autocmd de hijack abra el explorador en lugar de un buffer vacío.
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.uv.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require 'neo-tree'
      end
    end
  end,
  opts = {
    git_status_async = true,
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
    },
  },
}
