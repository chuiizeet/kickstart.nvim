return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = function()
    require("claudecode").setup({
      -- Run Claude in an external tmux pane (clean rendering). Neovim keeps only
      -- the WebSocket server + IDE tools (diffs, send, at-mentions, file awareness).
      -- Workflow: `:ClaudeCodeStart` in nvim, then `claude --ide` in the tmux pane.
      terminal = { provider = "none" },
    })

    -- After a send, focus the tmux pane where Claude runs (replaces
    -- focus_after_send, which has no effect with the "none" provider).
    vim.api.nvim_create_autocmd("User", {
      pattern = "ClaudeCodeSendComplete",
      callback = function()
        if vim.env.TMUX then
          vim.fn.system({ "tmux", "select-pane", "-R" })
        end
      end,
    })
  end,
  keys = {
    -- Start the WS server, then jump to the right-hand tmux pane to run `claude --ide`.
    {
      '<leader>ac',
      function()
        vim.cmd('ClaudeCodeStart')
        if vim.env.TMUX then
          vim.fn.system({ 'tmux', 'select-pane', '-R' })
        end
      end,
      desc = 'Start Claude server + focus tmux pane',
    },
    -- Focus only: jump to the Claude tmux pane without (re)starting the server.
    {
      '<leader>aF',
      function()
        if vim.env.TMUX then
          vim.fn.system({ 'tmux', 'select-pane', '-R' })
        end
      end,
      desc = 'Focus Claude tmux pane',
    },
    { '<leader>aS', '<cmd>ClaudeCodeStatus<cr>', desc = 'Claude server status' },
    { '<leader>ax', '<cmd>ClaudeCodeStop<cr>', desc = 'Stop Claude server' },
    { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select model' },
    { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
    { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
    { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
  },
}
