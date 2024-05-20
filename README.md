# Nvim Config - v0.10

## Todo

- [Try to use nix to lsp and treesitter](https://github.com/Kidsan/nixos-config/tree/main/home/programs/neovim)
  - Add `lsp` and `treesitter` files.
- Replace nodejs with bun for lsp
  - [Example](https://github.com/letieu/nvim-config/commit/237a314d06f87c528582d6da50d84ecac0fa7b27)
- Add [gitsign](https://github.com/lewis6991/gitsigns.nvim) in place of `dinhhuy258/git.nvim` and set keymaps.
- Set keymaps for `Neogit`.

## Undercurl

- `echo $TERM` has to be `xterm-256color` inside TMUX.
- Execute in terminal `infocmp > /tmp/${TERM}.ti`
- Open nvim `/tmp/${TERM}.ti`
- Add `Smulx=\E[4\:%p1%dm,` after `smul=\E[4m,`
- Execute in terminal `tic -x /tmp/${TERM}.ti`

## Sources:

- [How to get error underline to be like it is in vscode?](https://www.reddit.com/r/neovim/comments/11xsz20/comment/jd8cwvt/)
- [Curly Underlines in Kitty + Tmux + Neovim](https://evantravers.com/articles/2021/02/05/curly-underlines-in-kitty-tmux-neovim/)

## Resources:

- [ThePrimeahen config](https://github.com/ThePrimeagen/init.lua/tree/master)
- [Neovim - Bufferline Buffers vs Tabs vs Windows Explanation](https://www.youtube.com/watch?v=vJAmjAax2H0)
- [Why do Vim experts prefer buffers over tabs?](https://stackoverflow.com/questions/26708822/why-do-vim-experts-prefer-buffers-over-tabs/26710166#26710166)
