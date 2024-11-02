return {
  "jmsegrev/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()
    -- Remove default virtual lines.
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
}
