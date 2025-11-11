return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    {
      "<leader>rf",
      ---@diagnostic disable: undefined-global
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
  },
  init = function()
    -- Delete orphan buffers, not attach to tab nor win
    -- TODO: Check if buffer is a real file
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function(e)
        local buf = e.buf -- or vim.api.nvim_get_current_buf()
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        local name = vim.api.nvim_buf_get_name(buf)

        -- Continue only for real file buffer
        if buftype == "" and name ~= "" then
          local non_hidden_buffers = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            non_hidden_buffers[vim.api.nvim_win_get_buf(win)] = true
          end

          Snacks.bufdelete.delete(function(b)
            -- Don't delete the current buffer
            if buf == b then
              return false
            end

            -- Don't delete buffer present in other window
            if non_hidden_buffers[b] then
              return false
            end

            -- Autosave before closing
            if vim.bo[b].modified then
              -- Lsp format
              vim.lsp.buf.format({ bufnr = b })
              -- Save buffer
              vim.api.nvim_buf_call(b, vim.cmd.write)
            end

            -- Delete
            return true
          end)
        end
      end,
    })
  end,
}
