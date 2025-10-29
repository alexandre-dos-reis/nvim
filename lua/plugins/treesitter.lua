return {
  {
    "windwp/nvim-ts-autotag",
    events = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "lua",
        "tsx",
        "typescript",
        "javascript",
        "go",
        "templ",
        "astro",
        "cmake",
        "css",
        "scss",
        "fish",
        "gitignore",
        "markdown",
        "markdown_inline",
        "graphql",
        "http",
        "php",
        "rust",
        "sql",
        "nix",
        "just",
        "terraform",
        "nu",
        "zig",
        "cue",
        "c_sharp",
      },
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Mdx
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
