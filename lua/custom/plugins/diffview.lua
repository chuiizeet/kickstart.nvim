return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  config = function()
    require('diffview').setup {
      -- Puedes personalizar el layout y keymaps aquí si quieres
      use_icons = true,
      view = {
        merge_tool = {
          layout = 'diff3_mixed', -- o "diff3_horizontal"
          disable_diagnostics = true,
        },
      },
    }
  end,
}
