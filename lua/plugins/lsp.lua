return {
  -- INFO: Default configuration for lsp servers.
  -- To override a configuration, create a file there:
  -- `after/lsp/[lsp_server_name].lua`
  "neovim/nvim-lspconfig",
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    cond = function()
      return vim.fn.executable("vscode-json-languageserver") == 1
        or vim.fn.executable("yaml-language-server") == 1
    end,
  },
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
  {
    -- NOTE: Lsp is working, but treesitter is not...
    "Ripple-TS/ripple",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/nvim-plugin")

      vim.filetype.add({ extension = { ripple = "ripple" } })
      -- Configure treesitter to use the markdown parser for mdx files
      vim.treesitter.language.register("ripple", "ripple")

      require("ripple").setup(plugin)
    end,
  },
}
