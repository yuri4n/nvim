-- Neovim 0.12+. Every key is in CHEATSHEET.md (<Space>? opens it).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('config.options')
require('config.plugins')
require('config.lsp')
require('config.keymaps')
