return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = false, -- Cambiado a false para mejor control de colores
      autochdir = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = 'curved',
        winblend = 0, -- Cambiado para mejor visibilidad
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        highlights = {
          border = 'JolteonOrange', -- Usando tu tema Jolteon
          background = 'Normal',
        },
        title_pos = 'center',
      },
      winbar = {
        enabled = false,
      },
    }

    -- 🎨 Configurar colores para que respeten tu tema
    vim.cmd [[
      " Colores para terminal que respeten tu tema actual
      highlight TerminalNormal guibg=NONE ctermbg=NONE
      highlight TerminalNormalNC guibg=NONE ctermbg=NONE
      
      " Colores específicos para toggleterm con tu tema Jolteon
      highlight ToggleTermBorder guifg=#FFA500 gui=bold
      highlight ToggleTermFloat guibg=NONE
      highlight ToggleTermNormal guibg=NONE ctermbg=NONE
      
      " Mantener colores en terminal
      let g:terminal_color_0  = '#1e1e1e'
      let g:terminal_color_1  = '#ff6b6b'
      let g:terminal_color_2  = '#51cf66'
      let g:terminal_color_3  = '#ffd43b'
      let g:terminal_color_4  = '#74c0fc'
      let g:terminal_color_5  = '#f783ac'
      let g:terminal_color_6  = '#3bc9db'
      let g:terminal_color_7  = '#f8f9fa'
      let g:terminal_color_8  = '#495057'
      let g:terminal_color_9  = '#ff8787'
      let g:terminal_color_10 = '#8ce99a'
      let g:terminal_color_11 = '#FFD700'
      let g:terminal_color_12 = '#91a7ff'
      let g:terminal_color_13 = '#ffa8cc'
      let g:terminal_color_14 = '#66d9ef'
      let g:terminal_color_15 = '#ffffff'
    ]]

    -- ⚡ Función para terminal keymaps mejorada
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0, silent = true }
      -- Salir del modo terminal
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)

      -- Navegación entre ventanas desde terminal
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

      -- Redimensionar terminal
      vim.keymap.set('t', '<C-Left>', [[<Cmd>vertical resize -2<CR>]], opts)
      vim.keymap.set('t', '<C-Right>', [[<Cmd>vertical resize +2<CR>]], opts)
      vim.keymap.set('t', '<C-Up>', [[<Cmd>resize +2<CR>]], opts)
      vim.keymap.set('t', '<C-Down>', [[<Cmd>resize -2<CR>]], opts)
    end

    -- AutoCmd para aplicar keymaps
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*',
      callback = function()
        set_terminal_keymaps()
        -- Configurar opciones específicas del terminal
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'
      end,
    })

    -- 🚀 COMANDOS COOL PARA DIFERENTES TERMINALES

    -- Terminal Flotante (por defecto)
    vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = '⚡ Float Terminal', silent = true })

    -- Terminal Horizontal (abajo)
    vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', { desc = '📐 Horizontal Terminal', silent = true })

    -- Terminal Vertical (derecha)
    vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = '📏 Vertical Terminal', silent = true })

    -- Terminal en nueva pestaña
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=tab<cr>', { desc = '🗂️  Tab Terminal', silent = true })

    -- 🎯 COMANDOS ESPECÍFICOS Y ÚTILES

    -- Función para crear terminales específicos
    local Terminal = require('toggleterm.terminal').Terminal

    -- 📁 File Manager (ranger/lf/nnn)
    local ranger = Terminal:new {
      cmd = 'ranger',
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'curved',
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
    }

    function _RANGER_TOGGLE()
      ranger:toggle()
    end

    -- 🐍 Python REPL
    local python = Terminal:new {
      cmd = 'python3',
      direction = 'float',
      float_opts = {
        border = 'curved',
        title = ' 🐍 Python REPL ',
        title_pos = 'center',
      },
    }

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    -- 🌐 Node.js REPL
    local node = Terminal:new {
      cmd = 'node',
      direction = 'float',
      float_opts = {
        border = 'curved',
        title = ' 🌐 Node.js REPL ',
        title_pos = 'center',
      },
    }

    function _NODE_TOGGLE()
      node:toggle()
    end

    -- 📊 htop
    local htop = Terminal:new {
      cmd = 'htop',
      direction = 'float',
      float_opts = {
        border = 'curved',
        title = ' 📊 System Monitor ',
        title_pos = 'center',
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    }

    function _HTOP_TOGGLE()
      htop:toggle()
    end

    -- 📁 Lazygit
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'curved',
        title = ' 📁 Lazy Git ',
        title_pos = 'center',
        width = function()
          return math.floor(vim.o.columns * 0.95)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.95)
        end,
      },
    }

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    -- 🎵 Terminal con música (cmus/ncmpcpp)
    local music = Terminal:new {
      cmd = "cmus 2>/dev/null || ncmpcpp 2>/dev/null || echo 'Install cmus or ncmpcpp for music'",
      direction = 'float',
      float_opts = {
        border = 'curved',
        title = ' 🎵 Music Player ',
        title_pos = 'center',
      },
    }

    function _MUSIC_TOGGLE()
      music:toggle()
    end

    -- 🗂️ KEYMAPS PARA COMANDOS ESPECÍFICOS
    local keymap_opts = { noremap = true, silent = true }

    -- Terminales básicos
    vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = '⚡ Terminal Flotante' })
    vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', { desc = '📐 Terminal Horizontal' })
    vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = '📏 Terminal Vertical' })
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=tab<cr>', { desc = '🗂️ Terminal en Pestaña' })

    -- Comandos específicos
    vim.keymap.set('n', '<leader>tr', '<cmd>lua _RANGER_TOGGLE()<CR>', { desc = '📁 Ranger File Manager' })
    vim.keymap.set('n', '<leader>tp', '<cmd>lua _PYTHON_TOGGLE()<CR>', { desc = '🐍 Python REPL' })
    vim.keymap.set('n', '<leader>tn', '<cmd>lua _NODE_TOGGLE()<CR>', { desc = '🌐 Node.js REPL' })
    vim.keymap.set('n', '<leader>ts', '<cmd>lua _HTOP_TOGGLE()<CR>', { desc = '📊 System Monitor' })
    vim.keymap.set('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = '📁 Lazy Git' })
    vim.keymap.set('n', '<leader>tm', '<cmd>lua _MUSIC_TOGGLE()<CR>', { desc = '🎵 Music Player' })

    -- ⚡ Terminal rápido con Ctrl+`
    vim.keymap.set({ 'n', 'i', 't' }, '<C-`>', '<cmd>ToggleTerm<cr>', { desc = '⚡ Toggle Terminal Rápido' })

    -- 🎨 Auto-comando para mantener colores
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.cmd [[
          highlight ToggleTermBorder guifg=#FFA500 gui=bold
          highlight ToggleTermFloat guibg=NONE
          highlight ToggleTermNormal guibg=NONE ctermbg=NONE
          highlight TerminalNormal guibg=NONE ctermbg=NONE
          highlight TerminalNormalNC guibg=NONE ctermbg=NONE
        ]]
      end,
    })

    -- 📋 Mensaje de ayuda
    vim.api.nvim_create_user_command('TerminalHelp', function()
      print [[
⚡ COMANDOS DE TERMINAL DISPONIBLES:

📐 Básicos:
  <leader>tf  - Terminal Flotante
  <leader>th  - Terminal Horizontal  
  <leader>tv  - Terminal Vertical
  <leader>tt  - Terminal en Pestaña
  <C-`>       - Toggle Terminal Rápido

🛠️ Herramientas:
  <leader>tr  - 📁 Ranger (File Manager)
  <leader>tp  - 🐍 Python REPL
  <leader>tn  - 🌐 Node.js REPL
  <leader>ts  - 📊 htop (System Monitor)
  <leader>tg  - 📁 Lazygit
  <leader>tm  - 🎵 Music Player

🎮 En Terminal:
  <Esc>       - Salir modo insert
  <C-h/j/k/l> - Navegar ventanas
  <C-↑/↓/←/→> - Redimensionar
      ]]
    end, { desc = '📋 Ayuda de Terminal' })

    vim.keymap.set('n', '<leader>t?', '<cmd>TerminalHelp<cr>', { desc = '📋 Ayuda de Terminal' })
  end,
}
