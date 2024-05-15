return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    enabled = false,
  },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
  {
    -- Conflict with git config
    "gbprod/yanky.nvim",
    keys = {
      {
        "<leader>gp",
        false,
      },
      {

        "<leader>gP",
        false,
      },
    },
  },
}
