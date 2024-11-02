return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    on_highlights = function(hl, c)
      hl.TelescopeNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }
      hl.TelescopeBorder = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePromptNormal = {
        bg = c.bg_dark,
      }
      hl.TelescopePromptBorder = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePromptTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePreviewTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopeResultsTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
    end,
  },
  config = function(_, opts)
    require("solarized-osaka").setup(opts)
    vim.cmd.colorscheme("solarized-osaka")

    -- Remove bg color for error, warn, info and hint !
    vim.cmd([[highlight DiagnosticVirtualTextError guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextWarn guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextInfo guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextHint guibg=NONE]])
  end,
}
