return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- Golang Templ files
    "vrischmann/tree-sitter-templ",
  },
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
    -- vim.treesitter.language.register("markdown", "mdx")
  end,
}
