-- Actions (text editing actions are dot-repeatable out of the box and respect [count]) with configurable mappings:
--
--     Add surrounding with sa (in visual mode or on motion).
--     Delete surrounding with sd.
--     Replace surrounding with sr.
--     Find surrounding with sf or sF (move cursor right or left).
--     Highlight surrounding with sh.
return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }

    require('mini.surround').setup {}
  end,
}
