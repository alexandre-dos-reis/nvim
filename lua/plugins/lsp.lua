local LSPs = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            "vim",
            "require",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  ts_ls = {},
  nixd = {
    -- nix
    cmd = { "nixd" },
    settings = {
      nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
        },
        home_manager = {
          expr = '(builtins.getFlake "/home/alexandre/dev/nix-conf").homeConfigurations."lyc@adrastea".options',
        },
      },
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  config = function()
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    for lsp, config in pairs(LSPs) do
      config["capabilities"] = capabilities
      lspconfig[lsp].setup(config)
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gd", function()
      require("telescope.builtin").lsp_definitions({
        jump_type = "tab",
      })
    end, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  end,
}
