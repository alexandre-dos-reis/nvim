local ensure_installed = {
  "html",
  "lua",
  "tsx",
  "typescript",
  "javascript",
  "prisma",
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
}

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
  -- {
  --   "davidmh/mdx.nvim",
  --   config = true,
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter").install(ensure_installed)
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
