-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Remove concealled quotes, d-quotes, backticks, etc...
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "mdx", "markdown" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "pandoc" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "md" },
  command = "set nospell",
})

-- Small animate on yank
local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local bt = vim.api.nvim_buf_get_option(buf, "buftype")
    local name = vim.api.nvim_buf_get_name(buf)
    if bt == "" and name ~= "" then
      -- Only run for real file buffers
      require("close_buffers").delete({ type = "hidden", force = true })
    end
  end,
})
