-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local set = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc or nil })
end

-- Paste the clipboard content in Insert mode
-- TODO: make this available in telescope
set("i", "<C-v>", "<C-R>+")

-- kill highlight when escape press
set("n", "<Esc>", "<Esc>:noh<CR>")

-- recenter screen on page up and down
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")

-- recenter screen on search
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- dont yanwhen x is pressed
set("n", "x", '"_x')

-- Increment and decrement
set("n", "<leader>+", "<C-a>", "Increment number")
set("n", "<leader>-", "<C-x>", "Decrement number")

-- move selection in visual mode
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- move visual when indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- ep yank in the buffer on paste
set("x", "<leader>p", '"_dP')

-- Managing tabs
set("n", "<leader>to", ":tabnew<CR>")
set("n", "<leader>tq", ":tabclose<CR>")
set("n", "<leader>tn", ":tabn<CR>")
set("n", "<leader>tp", ":tabp<CR>")

-- tmux-sessionizer
set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Launch tmux-sessionizer")
-- set("n", "<C-w>", "<cmd>silent !tmux neww tmux-windownizer<CR>")

-- quicklist
set("n", "<C-n>", function()
  local success = pcall(vim.cmd, "cnext")
  if not success then
    vim.cmd("cfirst")
  end
end, "Navigate to the next quickfix item")

set("n", "<C-p>", function()
  local success = pcall(vim.cmd, "cprev")
  if not success then
    vim.cmd("clast")
  end
end, "Navigate to the previous quickfix item")

-- https://www.reddit.com/r/neovim/comments/wi4uf3/how_do_i_insert_current_date_or_time/
-- set("n", "<leader>ct", ":pu=strftime('%Y-%m-%d')<CR>", { desc = "Get today's data in yy-mm-dd format." })
