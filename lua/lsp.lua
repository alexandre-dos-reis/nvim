vim.lsp.enable({
  "nushell",
  "ansiblels",
  "lua_ls",
  "vtsls", -- or "tsgo", -- or "vtsls", -- or "ts_ls",
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

-- Use different layout for displaying diagnostic
-- require("lsp_lines").setup()

-- https://neovim.io/doc/user/diagnostic.html#diagnostic-signs
vim.diagnostic.config({
  -- virtual_lines = true,
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

-- keymap on buffer attach
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local set = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc or nil })
    end

    set("K", function()
      vim.lsp.buf.hover({ border = "rounded", silent = true })
    end, "LSP Hover definition")

    set("<leader>rn", function()
      vim.lsp.buf.rename()
    end, "LSP rename")

    set("gd", function()
      require("telescope.builtin").lsp_definitions({
        jump_type = "tab",
      })
    end, "LSP [g]o to [d]efinitions")

    set("gr", function()
      require("telescope.builtin").lsp_references()
    end, "LSP [g]o to [r]eferences")

    set("<leader>ca", vim.lsp.buf.code_action, "Show [c]ode [a]ctions")

    set("<C-e>", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Go to next diagnostic")

    set("E", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Go to previous diagnostic")
  end,
})
