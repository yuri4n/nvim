-- Plugins are installed by vim.pack and pinned in nvim-pack-lock.json.
-- :PackUpdate updates them.

-- Rebuild the parsers when nvim-treesitter changes. This must exist before vim.pack.add().
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end,
})

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add({
  gh('nvim-mini/mini.nvim'),
  gh('neovim/nvim-lspconfig'),
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
  { src = gh('saghen/blink.cmp'), version = vim.version.range('1') },
  { src = gh('catppuccin/nvim'), name = 'catppuccin' },
  gh('github/copilot.vim'),
}, { confirm = false })

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'Update plugins' })

-- Catppuccin Latte or Mocha, following the terminal's background.
vim.cmd.colorscheme('catppuccin')

-- mini.nvim: the UI and the small editing tools.
require('mini.icons').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.pairs').setup()
require('mini.bufremove').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.diff').setup({
  mappings = { goto_first = '[C', goto_prev = '[c', goto_next = ']c', goto_last = ']C' },
})
require('mini.pick').setup()
require('mini.extra').setup()
vim.ui.select = require('mini.pick').ui_select

-- The vim-surround keys (ys, ds, cs), as in Zed and IdeaVim.
require('mini.surround').setup({
  mappings = {
    add = 'ys',
    delete = 'ds',
    replace = 'cs',
    find = '',
    find_left = '',
    highlight = '',
    suffix_last = '',
    suffix_next = '',
  },
  search_method = 'cover_or_next',
})

-- Shows the next possible keys after a short wait.
local clue = require('mini.clue')
clue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
  },
  clues = {
    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>c', desc = '+Code' },
    { mode = 'n', keys = '<Leader>f', desc = '+Find' },
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
    clue.gen_clues.g(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
  },
})

-- Completion. <CR> accepts, as in Zed.
require('blink.cmp').setup({
  keymap = { preset = 'enter' },
  completion = { documentation = { auto_show = true } },
  signature = { enabled = true },
})

-- Tree-sitter parsers for the languages I use. Missing parsers compile in the
-- background; this needs the tree-sitter CLI and a C compiler.
require('nvim-treesitter').install({
  'bash', 'c', 'c_sharp', 'cpp', 'css', 'diff', 'dockerfile', 'eex', 'elixir', 'erlang',
  'gitcommit', 'go', 'graphql', 'haskell', 'heex', 'html', 'javascript', 'json', 'lua',
  'markdown', 'markdown_inline', 'nix', 'ocaml', 'python', 'regex', 'rust', 'scala', 'sql',
  'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'vue', 'yaml',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
