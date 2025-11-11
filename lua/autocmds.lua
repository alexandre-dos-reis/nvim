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

-- delete orphan buffer that are not related to tab nor windows.
-- Save it if modified
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function(e)
    -- Run slightly after the buffer switch settles
    vim.defer_fn(function()
      if not vim.api.nvim_buf_is_valid(e.buf) then
        return
      end

      -- Get the buffer we're switching *to*
      local next_buf = vim.api.nvim_get_current_buf()
      local next_bt = vim.api.nvim_get_option_value("buftype", { buf = next_buf })
      local next_name = vim.api.nvim_buf_get_name(next_buf)

      -- If the next buffer is a plugin / special buffer (Telescope, LSP, etc.), skip
      if next_bt ~= "" or next_name:match("^[%w%+%-]+://") then
        return
      end

      -- Only handle real file buffers
      local bt = vim.api.nvim_get_option_value("buftype", { buf = e.buf })
      local name = vim.api.nvim_buf_get_name(e.buf)
      if bt ~= "" or name == "" then
        return
      end

      -- Skip if still visible in any window (split, other tab, etc.)
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == e.buf then
          return
        end
      end

      -- Save if modified
      if vim.api.nvim_get_option_value("modified", { buf = e.buf }) then
        vim.api.nvim_buf_call(e.buf, function()
          vim.cmd("silent! write")
        end)
      end

      -- Finally, delete the buffer
      vim.api.nvim_buf_delete(e.buf, { force = true })
    end, 100) -- wait 100ms for buffer switch to settle
  end,
})
