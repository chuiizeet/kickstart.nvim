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
      shade_terminals = false,
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
      on_create = function()
        vim.opt_local.foldcolumn = '0'
        vim.opt_local.signcolumn = 'no'
      end,
      float_opts = {
        border = 'curved',
        winblend = 0,
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        highlights = {
          border = 'JolteonOrange',
          background = 'Normal',
        },
        title_pos = 'center',
      },
      winbar = {
        enabled = false,
      },
    }

    vim.cmd [[
      highlight TerminalNormal guibg=NONE ctermbg=NONE
      highlight TerminalNormalNC guibg=NONE ctermbg=NONE
      highlight ToggleTermBorder guifg=#FFA500 gui=bold
      highlight ToggleTermFloat guibg=NONE
      highlight ToggleTermNormal guibg=NONE ctermbg=NONE
      
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

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0, silent = true }
      local bufname = vim.api.nvim_buf_get_name(0)
      if
        not (
          string.match(bufname, 'lazygit')
          or string.match(bufname, 'ranger')
          or string.match(bufname, 'htop')
          or string.match(bufname, 'cmus')
          or string.match(bufname, 'ncmpcpp')
        )
      then
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)
      end

      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

      vim.keymap.set('t', '<C-Left>', [[<Cmd>vertical resize -2<CR>]], opts)
      vim.keymap.set('t', '<C-Right>', [[<Cmd>vertical resize +2<CR>]], opts)
      vim.keymap.set('t', '<C-Up>', [[<Cmd>resize +2<CR>]], opts)
      vim.keymap.set('t', '<C-Down>', [[<Cmd>resize -2<CR>]], opts)
    end

    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*',
      callback = function()
        set_terminal_keymaps()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'
      end,
    })

    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=float<cr>', { desc = '⚡ Terminal Flotante (Favorita)' })

    vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', { desc = '📐 Terminal Horizontal' })

    vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = '📏 Terminal Vertical' })

    vim.keymap.set({ 'n', 'i', 't' }, '<C-`>', '<cmd>ToggleTerm<cr>', { desc = '⚡ Toggle Rápido' })

    local Terminal = require('toggleterm.terminal').Terminal

    function _G._GIT_TOGGLE()
      local handle = io.popen 'which lazygit 2>/dev/null'
      local result = handle:read '*a'
      handle:close()

      local git_terminal
      if result and result ~= '' then
        git_terminal = Terminal:new {
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
      else
        git_terminal = Terminal:new {
          cmd = 'bash -c \'echo "📁 Terminal Git"; git status; exec bash\'',
          dir = 'git_dir',
          direction = 'float',
          float_opts = {
            border = 'curved',
            title = ' 📁 Terminal Git ',
            title_pos = 'center',
          },
        }
      end
      git_terminal:toggle()
    end

    vim.keymap.set('n', '<leader>tg', '<cmd>lua _GIT_TOGGLE()<CR>', { desc = '📁 Git/Lazygit' })

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
  end,
}
