return {
  "kazhala/close-buffers.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("close_buffers").setup({})

    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local bt = vim.api.nvim_buf_get_option(buf, "buftype")
        -- local bt = vim.api.nvim_get_option_value("buftype", { buf })

        local name = vim.api.nvim_buf_get_name(buf)

        if bt == "" and name ~= "" then
          -- Only run for real file buffers
          require("close_buffers").delete({ type = "hidden", force = true })
        end
      end,
    })
  end,
}
