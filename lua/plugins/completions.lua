return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "luckasRanarison/tailwind-tools.nvim",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
    },
    config = function()
      local cmp = require("cmp")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            before = require("tailwind-tools.cmp").lspkind_format,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          -- Internally <Tab> is mapped to <C-i>, so settings <Tab> sets <C-i> also.
          ["<Tab>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
          ["<S-CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        }),
        sources = cmp.config.sources({
          { name = "lazydev", group_index = 0 },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        }, {
          { name = "buffer" },
        }),
        completion = { completeopt = "menu,menuone,noinsert" },
      })
    end,
  },
}
