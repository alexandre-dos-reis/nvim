return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = false,
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
