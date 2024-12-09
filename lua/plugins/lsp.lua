local getLspConfig = function()
  return {
    lua_ls = {},
    vtsls = {
      on_attach = function(client, bufnr)
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
      end,
    }, -- or ts_ls
    jsonls = {
      settings = {
        json = {
          -- provide schemas for all king of json files
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
    yamlls = {
      settings = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    },
    bashls = {},
    tailwindcss = {},
    gopls = {},
    omnisharp = {
      cmd = { "OmniSharp" },
      enable_roslyn_analyzers = true,
      organize_imports_on_format = true,
      enable_import_completion = true,
      handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
        ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
        ["textDocument/references"] = require("omnisharp_extended").references_handler,
        ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
      },
      root_dir = function()
        return vim.loop.cwd() -- current working directory
      end,
    },
    postgres_lsp = {},
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#graphql
    graphql = {
      filetypes = { "graphql", "gql" },
    },
    rust_analyzer = {},
    zls = {}, -- zig
    terraform_lsp = {},
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
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "jmsegrev/lsp_lines.nvim",
    "yioneko/nvim-vtsls",
    "b0o/schemastore.nvim",
    "artemave/workspace-diagnostics.nvim",
    { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
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

    for lsp_name, config in pairs(getLspConfig()) do
      -- retrive any on_attach function previously defined
      local lsp_on_attach_config = config["on_attach"]

      config["on_attach"] = function(client, bufnr)
        if lsp_on_attach_config ~= nil then
          lsp_on_attach_config(client, bufnr)
        end
        -- disable semantic tokens for now as it is conflicting with the colorscheme
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
      float = { border = "rounded" },
      signs = {
        text = signs,
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
  end,
}
