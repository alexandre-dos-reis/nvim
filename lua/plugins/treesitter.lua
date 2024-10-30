return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "tsx",
      "typescript",
      "javascript",
      "go",
      "astro",
      "cmake",
      "css",
      "scss",
      "fish",
      "gitignore",
      "markdown",
      "graphql",
      "http",
      "php",
      "rust",
      "sql",
      "nix",
      "just",
      "terraform",
      "zig",
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
}
