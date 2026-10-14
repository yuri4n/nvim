local o = vim.o

-- Look
o.number = true
o.cursorline = true
o.signcolumn = 'yes'
o.wrap = false
o.scrolloff = 12
o.winborder = 'rounded'

-- Editing
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.undofile = true
o.confirm = true
o.updatetime = 250

-- Search
o.ignorecase = true
o.smartcase = true
o.inccommand = 'split'

-- Splits open to the right and below
o.splitright = true
o.splitbelow = true
