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
    ]]

    -- Colores ANSI del `:terminal`.
    --
    -- Antes estaban hardcodeados aquí y no tenían nada que ver con el tema. Ya
    -- no: los define el propio colorscheme (solarized-osaka lo hace con
    -- `terminal_colors = true`, que es el default), así que cambian solos al
    -- cambiar de tema.
    --
    -- Lo único que hacemos es reparar dos degeneraciones que trae el mapeo de
    -- solarized-osaka (y varios temas más) y que dejan texto ilegible:
    --
    --   * `terminal_color_8` (bright black) sale igual que el 0, que es el
    --     fondo. Todo lo que se pinte en bright-black --que es casi todo lo
    --     "tenue": lazygit, `ls`, diffs-- queda invisible.
    --   * Los brillantes 9-15 son idénticos a los normales 1-7, así que no se
    --     distinguen.
    --
    -- Es a propósito que el 0 sí se quede igual al fondo: ANSI 0 se usa casi
    -- siempre como color de fondo, no de texto, y que coincida es lo normal.
    local function hl_fg(name)
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      return hl.fg and string.format('#%06x', hl.fg) or nil
    end

    -- Aclara un color mezclándolo hacia blanco. amount: 0 = igual, 1 = blanco.
    local function lighten(hex, amount)
      local r, g, b = tostring(hex):match '^#(%x%x)(%x%x)(%x%x)$'
      if not r then
        return hex
      end
      local function mix(component)
        local value = tonumber(component, 16)
        return math.floor(value + (255 - value) * amount + 0.5)
      end
      return string.format('#%02x%02x%02x', mix(r), mix(g), mix(b))
    end

    local function same(a, b)
      return a and b and tostring(a):lower() == tostring(b):lower()
    end

    local function fix_terminal_colors()
      -- 8 = gris tenue. Si el tema lo dejó igual al 0, usar el color de los
      -- comentarios, que por definición es legible sobre el fondo.
      if same(vim.g.terminal_color_8, vim.g.terminal_color_0) then
        vim.g.terminal_color_8 = hl_fg 'Comment' or lighten(vim.g.terminal_color_0, 0.35)
      end

      for i = 9, 15 do
        local normal = vim.g['terminal_color_' .. (i - 8)]
        if same(vim.g['terminal_color_' .. i], normal) then
          vim.g['terminal_color_' .. i] = lighten(normal, 0.18)
        end
      end
    end

    fix_terminal_colors()

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
          or string.match(bufname, 'claude')
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
        -- El tema acaba de reescribir los terminal_color_*, hay que volver a
        -- repararlos.
        fix_terminal_colors()
      end,
    })
  end,
}
