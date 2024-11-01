return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
  config = function()
    vim.cmd.colorscheme("solarized-osaka")

    -- Remove bg color for error, warn, info and hint !
    vim.cmd([[highlight DiagnosticVirtualTextError guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextWarn guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextInfo guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextHint guibg=NONE]])
  end,
}
