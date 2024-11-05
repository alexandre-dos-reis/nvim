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
  -- ts_ls = {},
  vtsls = {},
  bashls = {},
  tailwindcss = {},
  gopls = {},
  rust_analyzer = {},
  zls = {}, -- zig
  nixd = {
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
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "jmsegrev/lsp_lines.nvim",
    "yioneko/nvim-vtsls",
  },
  config = function()
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
    local lspconfig = require("lspconfig")
    require("lspconfig.configs").vtsls = require("vtsls").lspconfig

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    local lspconfig_defaults = lspconfig.util.default_config
    lspconfig_defaults.capabilities =
      vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Override default style for lsp hover and signature
    local styleOpts = {
      border = "rounded",
      silent = true, -- Disable `No information available` notification
    }

    -- See this issue for empty docs around hover defs: https://github.com/neovim/neovim/issues/25718
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, styleOpts),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, styleOpts),
    }

    for lsp_name, config in pairs(LSPs) do
      -- style for hover and signature help
      config["handlers"] = handlers
      -- disable semantic tokens for now as it is conflicting with the colorscheme
      config["on_attach"] = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end
      lspconfig[lsp_name].setup(config)
    end

    local signs = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.HINT] = "●",
      [vim.diagnostic.severity.INFO] = "●",
    }

    -- Use different layout for displaying diagnostic
    -- require("lsp_lines").setup()

    -- https://neovim.io/doc/user/diagnostic.html#diagnostic-signs
    vim.diagnostic.config({
      -- virtual_text = {
      --   prefix = function(diagnostic)
      --     return signs[diagnostic.severity]
      --   end,
      -- },
      -- virtual_text = true, -- We are using a lsp_lines
      float = { border = "rounded" },
      signs = {
        text = signs,
      },

      -- Remove default virtual lines.
      vim.diagnostic.config({}),
    })

    -- keymap on buffer attach
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(event)
        local opts = { buffer = event.buf }
        local set = vim.keymap.set

        set("n", "K", vim.lsp.buf.hover, opts)

        set("n", "gd", function()
          require("telescope.builtin").lsp_definitions({
            jump_type = "tab",
          })
        end, opts)

        set("n", "gr", function()
          require("telescope.builtin").lsp_references()
        end, opts)

        set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        set("n", "<C-e>", vim.diagnostic.goto_next, opts)
        set("n", "E", vim.diagnostic.goto_prev, opts)
      end,
    })
  end,
}
