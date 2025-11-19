return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }

    require('mini.surround').setup {
      custom_surroundings = {
        p = {
          output = function()
            return { left = 'Padding(child: ', right = ',)' }
          end,
        },

        P = {
          output = function()
            local ans = vim.fn.input 'EdgeInsets (e.g. EdgeInsets.all(8.0)): '
            if ans == nil or ans == '' then
              ans = 'EdgeInsets.all(8.0)'
            end
            return { left = ('Padding(padding: ' .. ans .. ', child: '), right = ',)' }
          end,
        },

        c = {
          output = function()
            return { left = 'Container(child: ', right = ',)' }
          end,
        },

        e = {
          output = function()
            return { left = 'Expanded(child: ', right = ',)' }
          end,
        },

        s = {
          output = function()
            return { left = 'Stack(children: [', right = '],)' }
          end,
        },

        C = {
          output = function()
            return { left = 'Column(children: [', right = '],)' }
          end,
        },

        R = {
          output = function()
            return { left = 'Row(children: [', right = '],)' }
          end,
        },
      },
    }

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
