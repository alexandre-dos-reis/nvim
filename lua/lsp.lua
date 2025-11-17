vim.lsp.enable({
  "nushell",
  "ansiblels",
  "lua_ls",
  "vtsls", -- or "tsgo" or "vtsls" or "ts_ls"
  "cssls",
  "html",
  "astro",
  "jsonls",
  "yamlls",
  "phpactor",
  "bashls",
  "tailwindcss",
  "gopls",
  "templ",
  "postgres_lsp",
  "graphql",
  "rust_analyzer",
  "zls",
  "terraformls",
  "nixd",
})

local sign = "●"

-- https://neovim.io/doc/user/diagnostic.html#diagnostic-signs
vim.diagnostic.config({
  virtual_lines = false,
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = sign,
      [vim.diagnostic.severity.WARN] = sign,
      [vim.diagnostic.severity.HINT] = sign,
      [vim.diagnostic.severity.INFO] = sign,
    },
  },
})

local utils = require("utils")

-- keymap on buffer attach
utils.augroup("UserLspConfig", function(autocmd)
  autocmd("LspAttach", {
    desc = "LSP actions",
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(_)
      utils.set_keymaps({
        {
          "n",
          "K",
          function()
            vim.lsp.buf.hover({ border = "rounded", silent = true })
          end,
          "LSP Hover definition",
        },
        { "n", "<leader>rn", vim.lsp.buf.rename, "LSP rename" },
        {
          "n",
          "gd",
          function()
            require("telescope.builtin").lsp_definitions({
              jump_type = "tab",
            })
          end,
          "LSP [g]o to [d]efinitions",
        },
        {
          "n",
          "gr",
          function()
            require("telescope.builtin").lsp_references()
          end,
          "LSP [g]o to [r]eferences",
        },
        { "n", "<leader>ca", vim.lsp.buf.code_action, "Show [c]ode [a]ctions" },
        {
          "n",
          "<C-e>",
          function()
            vim.diagnostic.jump({ count = 1, float = true })
          end,
          "Go to next diagnostic",
        },
        {
          "n",
          "E",
          function()
            vim.diagnostic.jump({ count = -1, float = true })
          end,
          "Go to previous diagnostic",
        },
      })
    end,
  })
end)
