return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  ---@type blink.cmp.Config
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "none",
      ["<C-i>"] = { "show" },
      ["<CR>"] = { "accept" },
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      menu = { border = "rounded" },
      documentation = {
        window = { border = "rounded" },
        auto_show = false,
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { window = { border = "rounded" } },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
