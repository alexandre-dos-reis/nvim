return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = {
    { "<leader>td", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Global Workspace Diagnostics (Trouble)" },
  },
}
