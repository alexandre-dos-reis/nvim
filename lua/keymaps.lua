-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- kill highlight when escape press
set("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- recenter screen on page up and down
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")

-- recenter screen on search
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- dont yanwhen x is pressed
set("n", "x", '"_x')

-- Increment and decrement
set("n", "<leader>+", "<C-a>")
set("n", "<leader>-", "<C-x>")

-- move selection in visual mode
set("v", "J", ":m '>+1<CR>gv=gv", opts)
set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- move visual when indenting
set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

-- ep yank in the buffer on paste
set("x", "<leader>p", '"_dP')

-- Managing tabs
set("n", "<leader>to", ":tabnew<CR>")
set("n", "<leader>tq", ":tabclose<CR>")
set("n", "<leader>tn", ":tabn<CR>")
set("n", "<leader>tp", ":tabp<CR>")

-- tmux-sessionizer
set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- set("n", "<C-w>", "<cmd>silent !tmux neww tmux-windownizer<CR>")

-- quicist
set("n", "<C-q>", "<cmd>cnext<CR>zz")
set("n", "Q", "<cmd>cprev<CR>zz")

-- https://www.reddit.com/r/neovim/comments/wi4uf3/how_do_i_insert_current_date_or_time/
set("n", "<leader>ct", ":pu=strftime('%Y-%m-%d')<CR>", { desc = "Get today's data in yy-mm-dd format." })
