return {
  "stevearc/conform.nvim",
  event = { "BufReadPre" },
  cmd = { "ConformInfo" },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        lua = { "stylua" },
        nix = { "alejandra" },
        go = {
          -- This isn't working atm
          -- "goimports-reviser",
          "gofumpt",
          "golines",
        },
        sh = { "beautysh" },
        rust = { "rustfmt" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
      },
      format_after_save = {
        lsp_format = "fallback",
      },
    })
  end,
}
