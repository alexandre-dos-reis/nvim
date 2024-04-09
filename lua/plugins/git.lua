return {
  {
    "dinhhuy258/git.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("git").setup({
        blame = "<Leader>gb",
        browse = "<Leader>go",
        open_pull_request = "<Leader>gp",
        diff = nil,
        diff_close = nil,
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    branch = "nightly",
    config = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
}
