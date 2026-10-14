# Cheat sheet

The leader key is `Space`. `Space ?` opens this file in Neovim, and after a
short wait Neovim shows the keys that can follow a prefix.

The **Zed** column shows whether the same key works in Zed's vim mode.

## Basics

| Keys                     | Action                         | Zed |
| ------------------------ | ------------------------------ | :-: |
| `jk`                     | Leave insert mode              | ✓   |
| `Esc`                    | Clear the search highlight     |     |
| `Space ?`                | Open this cheat sheet          |     |
| `[b` / `]b`              | Previous / next buffer         | ✓   |
| `Space bd`               | Close the buffer               | ✓   |
| `Space e`                | File explorer                  | ✓   |
| `Ctrl-w h/j/k/l`         | Move to the split on that side | ✓   |
| `gcc`, `gc{motion}`      | Comment or uncomment           | ✓   |
| `ys{motion}{char}`       | Surround a motion              | ✓   |
| `yss{char}`              | Surround the line              | ✓   |
| `ds{char}`               | Delete the surrounding pair    | ✓   |
| `cs{old}{new}`           | Change the surrounding pair    | ✓   |
| `S{char}` (visual)       | Surround the selection         |     |

## Find

| Keys        | Action                 | Zed |
| ----------- | ---------------------- | :-: |
| `Space ff`  | Files                  | ✓   |
| `Space fg`  | Grep in the project    | ✓   |
| `Space fb`  | Open buffers           | ✓   |
| `Space fr`  | Recent files           |     |
| `Space fh`  | Help                   |     |
| `Space fs`  | Symbols in the file    | ✓   |
| `Space fS`  | Symbols in the project | ✓   |
| `Space fd`  | Diagnostics            | ✓   |

## Code

| Keys                | Action                         | Zed |
| ------------------- | ------------------------------ | :-: |
| `gd`                | Go to definition               | ✓   |
| `gD`                | Go to declaration              | ✓   |
| `grr`               | References                     | ✓   |
| `gri`               | Implementations                | ✓   |
| `grt`               | Type definition                | ✓   |
| `grn`               | Rename                         | ✓   |
| `gra`               | Code actions                   | ✓   |
| `gO`                | Outline of the file            | ✓   |
| `K`                 | Hover documentation            | ✓   |
| `Ctrl-s` (insert)   | Signature help                 | ✓   |
| `[d` / `]d`         | Previous / next diagnostic     | ✓   |
| `Ctrl-w d`          | Diagnostic under the cursor    |     |
| `Space cf`          | Format the file                | ✓   |
| `Space th`          | Toggle inlay hints             | ✓   |

Files are formatted on save in both editors.

## Git

| Keys        | Action                      | Zed |
| ----------- | --------------------------- | :-: |
| `[c` / `]c` | Previous / next hunk        | ✓   |
| `Space gs`  | Stage the hunk              | ✓   |
| `Space gr`  | Reset the hunk              | ✓   |
| `Space gd`  | Show the diff               | ✓   |
| `Space gb`  | Blame                       | ✓   |
| `Space gg`  | Git status (Zed: git panel) | ✓   |

## Completion and Copilot

| Keys            | Action                  | Zed |
| --------------- | ----------------------- | :-: |
| `Ctrl-Space`    | Open completion         | ✓   |
| `Enter`         | Accept                  | ✓   |
| `Ctrl-n/Ctrl-p` | Next / previous item    | ✓   |
| `Ctrl-e`        | Close completion        |     |
| `Tab`           | Accept Copilot's idea   | ✓   |

## Only in Zed

| Keys               | Action                          |
| ------------------ | ------------------------------- |
| `Ctrl-Alt-Cmd-p`   | Switch the settings profile     |
| `Ctrl-Shift-h`     | Toggle inlay hints              |
| `Ctrl-Shift-Cmd-i` | Agent panel                     |
| `Shift-Alt-Cmd-i`  | New agent thread                |

## Neovim commands

| Command          | Action                               |
| ---------------- | ------------------------------------ |
| `:PackUpdate`    | Update the plugins (`:w` confirms)   |
| `:Git {args}`    | Run git                              |
| `:Copilot setup` | Sign in to Copilot, once per machine |
| `:checkhealth`   | Check the setup                      |
