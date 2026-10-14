# nvim

My Neovim config. It is small, it builds on the Neovim 0.12 defaults, and it
uses the same keys as my Zed setup. [CHEATSHEET.md](CHEATSHEET.md) lists every
key, and `Space ?` opens it.

## Install

You need Neovim 0.12+, git, ripgrep, the tree-sitter CLI and a C compiler.

```sh
git clone https://github.com/yuri4n/nvim ~/.config/nvim
nvim
```

The plugins install on the first start, at the revisions in
`nvim-pack-lock.json`. The Tree-sitter parsers then compile in the background.
`:PackUpdate` updates the plugins.

A language server starts when its program is on PATH. My
[Home Manager setup](https://github.com/yuri4n/home) installs them.

## Files

| File                     | Contents                                    |
| ------------------------ | ------------------------------------------- |
| `init.lua`               | Leader key and the modules below            |
| `lua/config/options.lua` | Editor options                              |
| `lua/config/plugins.lua` | Plugins and their setup                     |
| `lua/config/lsp.lua`     | Language servers, diagnostics, formatting   |
| `lua/config/keymaps.lua` | Every keymap                                |

## Plugins

- [mini.nvim](https://github.com/nvim-mini/mini.nvim): icons, statusline,
  tabline, pairs, surround, picker, file explorer, git and diff, key hints
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): server defaults
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): parsers
- [blink.cmp](https://github.com/saghen/blink.cmp): completion
- [catppuccin](https://github.com/catppuccin/nvim): colors
- [copilot.vim](https://github.com/github/copilot.vim): Copilot
