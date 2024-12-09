return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- bigfile = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    {
      "<leader>rf",
      ---@diagnostic disable: undefined-global
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
  },
}
