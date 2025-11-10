local ensure_installed = {
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
  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed,
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- NOTE: Taken from https://github.com/davidmh/mdx.nvim/blob/main/after/queries/markdown/injections.scm
      -- Register the mdx filetype
      vim.filetype.add({ extension = { mdx = "mdx" } })
      -- Configure treesitter to use the markdown parser for mdx files
      vim.treesitter.language.register("markdown", "mdx")
      -- If the current buffer has the extension mdx, but not the newly create filetype, set it
      if vim.endswith(vim.api.nvim_buf_get_name(0), ".mdx") and vim.o.filetype ~= "mdx" then
        vim.o.filetype = "mdx"
      end
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
