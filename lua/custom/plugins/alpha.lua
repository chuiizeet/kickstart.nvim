return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⢱⡄⠀⠀⠀⠀⠀⠀⠀⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣦⡀⠀⠀⢀⠀⢠⣿⣷⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⣄⠀⠀⠀⠀⠀⠀⢢⣸⣿⣷⣄⠀⠸⡄⢸⣿⣿⡆⣿⡀⠀⠘⡢⡀⠀⠀⠀⠀⠀⠀⡿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠈⢻⣶⣤⡀⠀⠀⠀⢻⣿⣿⣿⣧⡀⣿⣾⣿⣿⣿⣿⣧⠀⠀⢃⠈⠢⡀⠀⢰⡀⢰⠀⢳⠀⠀⠀⡀⠀⠀⣠⠀⣴⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠹⣿⣿⣷⣦⣄⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⠙⢷⣦⣘⡀⠀⠈⠢⣸⠐⠌⠀⠀⢇⠀⡔⡇⢀⠜⣧⡾⠃⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠈⢻⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠈⠻⣷⣄⡀⠀⠈⠀⠀⣆⠀⠘⠜⠀⡧⠁⣰⡟⠁⢰⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠈⠻⣷⣄⠀⠀⠀⣿⣦⠀⠀⠀⠀⢀⡟⠀⠀⣼⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⣀⣀⣀⣈⣑⣲⣬⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣿⣆⠀⠀⠀⠈⢿⡆⢦⡀⢸⣿⣧⢸⣆⠀⣸⠃⠀⣸⢋⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠉⠳⣦⡀⠀⠈⣿⣾⣿⣾⣿⣿⣿⣿⣿⣏⢀⣜⠉⠌⠀⢂⠜⠁⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⢀⣉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣉⠙⠛⠛⠓⠀⠀⠈⢿⣦⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⠀⠀⡠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠈⠉⢉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣀⠀⠀⠀⢈⣽⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢀⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⣀⣠⣾⣿⣿⣿⣿⣿⣿⣿⡟⠛⣿⣿⣿⣿⣯⣍⣉⡁⠀⠀⣰⢿⣿⣿⣧⠀⠈⠙⢿⣿⣿⣿⣿⠏⠁⡏⠓⠒⢀⡠⠄⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⣿⣿⣿⣿⡿⠟⠋⣀⡀⠀⢁⣿⣿⣿⣿⣶⣤⣤⣼⣿⣿⣿⣿⣤⣼⡇⠀⠘⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⣼⣿⣿⣿⣿⣿⠿⠟⠛⠁⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠸⠟⡽⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⠃⠀⠀⠀⠉⠢⣄⠀⠀⠀⠀⠀⠀⠀',
      '⠀⢀⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⡿⠁⠀⢀⣠⠄⠀⠁⠟⠋⠛⠻⣿⣿⣿⣿⣿⣿⠟⠁⢠⡬⠽⠯⠭⠉⠉⠁⠀⠀⠀⠀⠀⠀',
      '⠀⣼⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⢏⣠⣴⠾⢋⡦⡾⠀⠀⠀⠀⡀⠀⠈⠉⠛⠛⠛⢁⠀⠀⠀⠳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⢠⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⠀⠊⢠⠃⠀⢀⠄⠺⡰⡇⠀⡰⠣⡀⣸⣮⣿⣶⣦⣄⡱⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⢸⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⠀⠀⡜⡠⠒⠁⠀⠋⠀⣇⡜⠀⠀⠱⡏⠙⠻⢿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠙⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣿⣿⣿⣷⡀⠐⠁⠀⠀⠀⠀⠀⠀⠟⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣷⣤⣀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣿⣶⣦⡀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⠿⠿⠛⠁',
      '',
      '              💛 TCGDex to the moon 💛',
      '',
    }

    dashboard.section.buttons.val = {
      dashboard.button('f', '⚡   Search', ':Telescope find_files<CR>'),
      dashboard.button('r', '🌟   History', ':Telescope oldfiles<CR>'),
      dashboard.button('n', '✨  Generate File', ':ene <BAR> startinsert<CR>'),
      dashboard.button('u', '🔋  Plugins', ':Lazy update<CR>'),
      dashboard.button('q', '💫  Bye bye', ':qa<CR>'),
    }

    local function get_enhanced_stats()
      local lazy_stats = { count = 0, loaded = 0, startup_time = 0 }
      local ok, lazy = pcall(require, 'lazy')
      if ok and type(lazy) == 'table' and type(lazy.stats) == 'function' then
        local stats = lazy.stats()
        lazy_stats = {
          count = stats.count or 0,
          loaded = stats.loaded or 0,
          startup_time = math.max(stats.startuptime or 0, stats.startup_time or 0),
        }
      end

      local vim_startup_time = 0
      if vim.fn.has 'reltime' == 1 and vim.g.start_time then
        vim_startup_time = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000
      end

      local uptime_ms = 0
      local uv = vim.loop or vim.uv
      if uv and uv.uptime then
        uptime_ms = uv.uptime() * 1000
      end

      return {
        lazy = lazy_stats,
        vim_time = vim_startup_time,
        uptime = uptime_ms,
      }
    end

    local function create_footer()
      local stats = get_enhanced_stats()
      local footer_lines = {
        '⚡ Make beautiful thigs! ⚡',
      }

      if stats.lazy.count > 0 then
        local loaded_text = stats.lazy.loaded > 0 and string.format('🔋 %d/%d electric powers active', stats.lazy.loaded, stats.lazy.count)
          or string.format('💡 %d lightning abilities learned', stats.lazy.count)
        table.insert(footer_lines, loaded_text)
      end

      local startup_time = 0
      local time_source = ''

      if stats.lazy.startup_time > 0 then
        startup_time = stats.lazy.startup_time
        time_source = 'lazy'
      elseif stats.vim_time > 0 then
        startup_time = stats.vim_time
        time_source = 'vim'
      elseif stats.uptime > 0 and stats.uptime < 10000 then -- Solo si es < 10s
        startup_time = stats.uptime
        time_source = 'uptime'
      end

      if startup_time > 0 then
        local time_text = startup_time < 1 and string.format('⚡ Lightning strike in %.2fms (%s)', startup_time, time_source)
          or string.format('⚡ Lightning strike in %.0fms (%s)', startup_time, time_source)
        table.insert(footer_lines, time_text)
      else
        table.insert(footer_lines, '💫 Instant electric shock! (< 1ms)')
      end

      table.insert(footer_lines, string.format('🎯 Neovim %s', vim.version().major .. '.' .. vim.version().minor))

      return footer_lines
    end

    dashboard.section.footer.val = create_footer()

    vim.cmd [[
      " Degradado amarillo-naranja eléctrico y energético
      highlight JolteonLightYellow guifg=#FFFACD gui=bold
      highlight JolteonYellow guifg=#FFFF00 gui=bold
      highlight JolteonGold guifg=#FFD700 gui=bold
      highlight JolteonAmber guifg=#FFC000 gui=bold
      highlight JolteonOrange guifg=#FFA500 gui=bold
      highlight JolteonDarkOrange guifg=#FF8C00 gui=bold
      highlight JolteonTangerine guifg=#FF7F00 gui=bold
      highlight JolteonElectric guifg=#FF6600 gui=bold
      highlight JolteonDeepOrange guifg=#FF4500 gui=bold
      highlight JolteonFireOrange guifg=#FF2500 gui=bold
      
      " Efectos especiales eléctricos
      highlight JolteonSpark guifg=#FFFF00 gui=bold,italic
      highlight JolteonBolt guifg=#FFC000 gui=bold,underline
      highlight JolteonThunder guifg=#FF8C00 gui=bold,italic
      highlight JolteonEnergy guifg=#FF6600 gui=bold
      highlight JolteonGlow guifg=#FFFACD gui=bold,italic
      
      " Footer y botones con máxima energía
      highlight AlphaFooter guifg=#FFA500 gui=italic
      highlight AlphaButtons guifg=#FF8C00 gui=bold
      highlight AlphaHeader guifg=#FFC000 gui=bold
    ]]

    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.footer.opts.hl = 'AlphaFooter'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        dashboard.section.footer.val = create_footer()
        pcall(alpha.redraw)
      end,
    })

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.cmd [[
          highlight JolteonLightYellow guifg=#FFFACD gui=bold
          highlight JolteonYellow guifg=#FFFF00 gui=bold
          highlight JolteonGold guifg=#FFD700 gui=bold
          highlight JolteonAmber guifg=#FFC000 gui=bold
          highlight JolteonOrange guifg=#FFA500 gui=bold
          highlight JolteonDarkOrange guifg=#FF8C00 gui=bold
          highlight JolteonTangerine guifg=#FF7F00 gui=bold
          highlight JolteonElectric guifg=#FF6600 gui=bold
          highlight JolteonDeepOrange guifg=#FF4500 gui=bold
          highlight JolteonFireOrange guifg=#FF2500 gui=bold
          highlight JolteonSpark guifg=#FFFF00 gui=bold,italic
          highlight JolteonBolt guifg=#FFC000 gui=bold,underline
          highlight JolteonThunder guifg=#FF8C00 gui=bold,italic
          highlight JolteonEnergy guifg=#FF6600 gui=bold
          highlight JolteonGlow guifg=#FFFACD gui=bold,italic
          highlight AlphaFooter guifg=#FFA500 gui=italic
          highlight AlphaButtons guifg=#FF8C00 gui=bold
          highlight AlphaHeader guifg=#FFC000 gui=bold
        ]]
      end,
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        if vim.fn.argc() == 0 then
          vim.defer_fn(function()
            vim.cmd 'echo "⚡ Jolteon unleashes a powerful Thunder Shock! Your editor is now charged! ⚡"'
          end, 100)
        end
      end,
    })

    local jolteon_electric_colors = { 'JolteonAmber', 'JolteonOrange', 'JolteonElectric' }
    local color_index = 1

    vim.api.nvim_create_autocmd('CursorHold', {
      callback = function()
        if vim.bo.filetype == 'alpha' then
          dashboard.section.header.opts.hl = jolteon_electric_colors[color_index]
          color_index = color_index % #jolteon_electric_colors + 1
          pcall(alpha.redraw)
        end
      end,
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = function()
        if vim.bo.filetype == 'alpha' and math.random(150) == 77 then
          dashboard.section.header.opts.hl = 'JolteonSpark'
          vim.defer_fn(function()
            dashboard.section.header.opts.hl = 'JolteonAmber'
            pcall(alpha.redraw)
          end, 150)
        end
      end,
    })

    vim.api.nvim_create_autocmd('InsertEnter', {
      callback = function()
        if math.random(100) == 25 then
          local flash_colors = { 'JolteonYellow', 'JolteonGold', 'JolteonOrange', 'JolteonElectric' }
          for i, color in ipairs(flash_colors) do
            vim.defer_fn(function()
              if vim.bo.filetype == 'alpha' then
                dashboard.section.header.opts.hl = color
                pcall(alpha.redraw)
              end
            end, i * 100)
          end
          vim.defer_fn(function()
            dashboard.section.header.opts.hl = 'JolteonAmber'
            pcall(alpha.redraw)
          end, 500)
        end
      end,
    })
  end,
}
