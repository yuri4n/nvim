-- Every keymap of this config. CHEATSHEET.md lists them with the Neovim
-- defaults they build on (grn, gra, grr, [d, ...). Zed's vim mode uses the same keys.
-- Plugin options in plugins.lua add two more: ys/ds/cs (surround) and [c/]c (git hunks).

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

-- Basics
map('i', 'jk', '<Esc>', 'Normal mode')
map('n', '<Esc>', '<Cmd>nohlsearch<CR>', 'Clear search highlight')
map('n', '<Leader>?', function()
  vim.cmd.sview(vim.fn.stdpath('config') .. '/CHEATSHEET.md')
end, 'Cheat sheet')
map('n', '<Leader>bd', function()
  require('mini.bufremove').delete()
end, 'Close buffer')
map('n', '<Leader>e', function()
  local file = vim.api.nvim_buf_get_name(0)
  require('mini.files').open(vim.uv.fs_stat(file) and file or nil)
end, 'File explorer')

-- Surround: S wraps a selection, yss wraps the line.
vim.keymap.del('x', 'ys')
map('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], 'Surround selection')
vim.keymap.set('n', 'yss', 'ys_', { remap = true, desc = 'Surround line' })

-- Find
local pick = require('mini.pick').builtin
local extra = require('mini.extra').pickers
map('n', '<Leader>ff', pick.files, 'Files')
map('n', '<Leader>fg', pick.grep_live, 'Grep')
map('n', '<Leader>fb', pick.buffers, 'Buffers')
map('n', '<Leader>fr', extra.oldfiles, 'Recent files')
map('n', '<Leader>fh', pick.help, 'Help')
map('n', '<Leader>fd', extra.diagnostic, 'Diagnostics')
map('n', '<Leader>fs', function()
  extra.lsp({ scope = 'document_symbol' })
end, 'Symbols in file')
map('n', '<Leader>fS', function()
  extra.lsp({ scope = 'workspace_symbol' })
end, 'Symbols in project')

-- Code. Neovim maps grn, gra, grr, gri, grt, gO, K and [d/]d by itself.
map('n', '<Leader>cf', function()
  require('config.lsp').format(0)
end, 'Format file')
map('n', '<Leader>th', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, 'Toggle inlay hints')

-- gd and gD go through the language server only where one is attached.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('config.lsp-keys', {}),
  callback = function(ev)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Go to definition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'Go to declaration' })
  end,
})

-- Git
local function hunk(action)
  return function()
    local line = vim.fn.line('.')
    require('mini.diff').do_hunks(0, action, { line_start = line, line_end = line })
  end
end
map('n', '<Leader>gs', hunk('apply'), 'Stage hunk')
map('n', '<Leader>gr', hunk('reset'), 'Reset hunk')
map('n', '<Leader>gd', function()
  require('mini.diff').toggle_overlay(0)
end, 'Toggle diff')
map('n', '<Leader>gb', function()
  require('mini.git').show_at_cursor()
end, 'Blame at cursor')
map('n', '<Leader>gg', '<Cmd>Git status<CR>', 'Git status')
