return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,

        indicator = {
          icon = '',
          style = 'underline',
        },

        buffer_close_icon = '',
        modified_icon = '•',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',

        max_name_length = 25,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = false,
        diagnostics_update_in_insert = false,

        offsets = {
          {
            filetype = 'NvimTree',
            text = '',
            text_align = 'center',
            separator = false,
          },
          {
            filetype = 'neo-tree',
            text = '',
            text_align = 'center',
            separator = false,
          },
        },

        color_icons = true, -- Sin iconos de colores
        show_buffer_icons = true, -- Sin iconos de archivos
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
          enabled = false, -- Sin hover
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current',
      },

      highlights = {
        background = {
          guifg = '#6c6c6c',
          guibg = 'NONE', -- Transparente
        },

        buffer_selected = {
          guifg = '#ffffff',
          guibg = 'NONE', -- Transparente
          gui = 'NONE', -- Sin bold
        },

        buffer_visible = {
          guifg = '#a0a0a0',
          guibg = 'NONE', -- Transparente
        },

        indicator_selected = {
          guifg = '#ffffff',
          guibg = 'NONE',
        },

        separator = {
          guifg = 'NONE',
          guibg = 'NONE',
        },
        separator_selected = {
          guifg = 'NONE',
          guibg = 'NONE',
        },
        separator_visible = {
          guifg = 'NONE',
          guibg = 'NONE',
        },

        modified = {
          guifg = '#ffffff',
          guibg = 'NONE',
        },
        modified_selected = {
          guifg = '#ffffff',
          guibg = 'NONE',
        },

        fill = {
          guibg = 'NONE',
        },

        duplicate = {
          guifg = '#6c6c6c',
          guibg = 'NONE',
          gui = 'NONE',
        },
        duplicate_selected = {
          guifg = '#ffffff',
          guibg = 'NONE',
          gui = 'NONE',
        },
      },
    }

    vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
    vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
    vim.keymap.set('n', '<leader>x', '<cmd>bdelete<cr>')
    vim.keymap.set('n', '<leader>X', '<cmd>BufferLineCloseOthers<cr>')
  end,
}
