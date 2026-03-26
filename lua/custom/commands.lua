-- Custom user commands and functions

-- Auto-reload files changed outside nvim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  command = 'silent! checktime',
})

-- Refresh neo-tree git status on external changes
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'BufWritePost' }, {
  callback = function()
    if package.loaded['neo-tree.sources.manager'] then
      require('neo-tree.sources.manager').refresh('filesystem')
    end
  end,
})

-- NOTE: Delete emojis
vim.api.nvim_create_user_command('DeleteEmojis', function()
  vim.cmd [[%s/\v[\U0001F600-\U0001F64F\U0001F300-\U0001F5FF\U0001F680-\U0001F6FF\U0001F900-\U0001F9FF\U0001FA00-\U0001FA6F\U0001FA70-\U0001FAFF\U00002702-\U000027B0\U0000FE00-\U0000FE0F\U0000200D\U00002600-\U000026FF\U00002700-\U000027BF]//ge]]
end, { desc = 'Delete all emojis from the current buffer' })

-- NOTE: Delete comments
vim.api.nvim_create_user_command('DeleteComments', function()
  local ft = vim.bo.filetype

  if ft == 'python' or ft == 'gdscript' then
    vim.cmd [[g/^\s*#/d]]
  elseif ft == 'javascript' or ft == 'typescript' or ft == 'c' or ft == 'cpp' or ft == 'java' or ft == 'dart' then
    vim.cmd [[g/^\s*\/\/\|^\s*\/\*/d]]
  elseif ft == 'lua' then
    vim.cmd [[g/^\s*--/d]]
  elseif ft == 'vim' then
    vim.cmd [[g/^\s*"/d]]
  else
    print('File type not supported: ' .. ft)
  end
end, {
  desc = 'Delete all comments in the current buffer',
})

-- NOTE: Insert Rel path for some llms
vim.api.nvim_create_user_command('InsertRelPath', function()
  local buf = vim.api.nvim_get_current_buf()

  local filepath = vim.fn.expand '%:p'
  local cwd = vim.fn.getcwd()
  local relpath = filepath:gsub('^' .. vim.pesc(cwd), '')
  if relpath == '' then
    relpath = '/' .. vim.fn.expand '%:t'
  end

  local ft = vim.bo.filetype

  local comment_prefix_by_ft = {
    c = '//',
    cpp = '//',
    h = '//',
    hpp = '//',
    java = '//',
    kotlin = '//',
    swift = '//',
    dart = '//',
    go = '//',
    rust = '//',
    scala = '//',

    python = '#',
    ruby = '#',
    perl = '#',
    sh = '#',
    bash = '#',
    zsh = '#',
    lua = '--',
    gdscript = '#',

    html = '<!--',
    xml = '<!--',
    svg = '<!--',
    vue = '<!--',
    svelte = '<!--',
    php = '//',
    css = '/*',
    scss = '/*',

    json = '//',
    jsonc = '//',
    yaml = '#',
    toml = '#',

    javascript = '//',
    typescript = '//',
    jsx = '//',
    tsx = '//',
  }

  local prefix = comment_prefix_by_ft[ft] or '//'
  local suffix = ''
  if prefix == '<!--' then
    suffix = ' -->'
  elseif prefix == '/*' then
    suffix = ' */'
  end

  local line = prefix .. ' ' .. relpath .. suffix

  vim.api.nvim_buf_set_lines(buf, 0, 0, false, { line })
end, { desc = 'Insert relative file path (cwd-based) as comment at top' })

-- NOTE: Insert header comment block
local function insert_header_comment()
  local title = vim.fn.input 'Header text: '
  if not title or title == '' then
    title = 'HEADER'
  end

  title = string.upper(title)

  local cs = vim.bo.commentstring
  local prefix

  if cs and cs:match '%%s' then
    prefix = cs:sub(1, cs:find '%%s' - 1)
  else
    prefix = '//'
  end

  prefix = prefix:gsub('%s+$', '')

  local width = 41
  local border = prefix .. ' ' .. string.rep('=', width)
  local middle = prefix .. ' ' .. title

  local lines = { border, middle, border }

  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)

  vim.api.nvim_win_set_cursor(0, { row + 2, #middle })
end

_G.InsertHeaderComment = insert_header_comment

vim.keymap.set('n', '<leader>hh', function()
  insert_header_comment()
end, { desc = 'Insert header comment block' })
