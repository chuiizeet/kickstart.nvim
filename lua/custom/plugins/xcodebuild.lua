return {
  'wojciech-kulik/xcodebuild.nvim',
  -- Carga perezosa: al abrir archivos Swift/ObjC, al correr un comando :Xcodebuild*,
  -- o al presionar cualquier keymap <leader>X*.
  ft = { 'swift', 'objc', 'objcpp' },
  cmd = {
    'XcodebuildSetup',
    'XcodebuildPicker',
    'XcodebuildBuild',
    'XcodebuildBuildRun',
    'XcodebuildRun',
    'XcodebuildTest',
    'XcodebuildProjectManager',
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    'stevearc/oil.nvim', -- (opcional) gestionar archivos del proyecto; neo-tree también funciona
    'nvim-treesitter/nvim-treesitter', -- (opcional) Quick tests (requiere parser de Swift)
  },
  config = function()
    require('xcodebuild').setup {
      -- Opciones por defecto. Ver :help xcodebuild para personalizar.
    }

    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { desc = 'Xcode: ' .. desc })
    end

    map('<leader>XX', '<cmd>XcodebuildPicker<cr>', 'Show all actions')
    map('<leader>XS', '<cmd>XcodebuildSetup<cr>', 'Project setup wizard')
    map('<leader>Xb', '<cmd>XcodebuildBuild<cr>', 'Build')
    map('<leader>Xr', '<cmd>XcodebuildBuildRun<cr>', 'Build & Run')
    map('<leader>XR', '<cmd>XcodebuildRun<cr>', 'Run (without build)')
    map('<leader>Xc', '<cmd>XcodebuildClean<cr>', 'Clean build folder')
    map('<leader>Xt', '<cmd>XcodebuildTest<cr>', 'Run tests')
    map('<leader>XT', '<cmd>XcodebuildTestClass<cr>', 'Run this test class')
    map('<leader>Xe', '<cmd>XcodebuildTestExplorerToggle<cr>', 'Toggle test explorer')
    map('<leader>Xl', '<cmd>XcodebuildToggleLogs<cr>', 'Toggle build logs')
    map('<leader>Xd', '<cmd>XcodebuildSelectDevice<cr>', 'Select device')
    map('<leader>Xs', '<cmd>XcodebuildSelectScheme<cr>', 'Select scheme')
    map('<leader>Xo', '<cmd>XcodebuildToggleCodeCoverage<cr>', 'Toggle code coverage')
    map('<leader>Xp', '<cmd>XcodebuildProjectManager<cr>', 'Project manager (add/remove files)')
  end,
}
