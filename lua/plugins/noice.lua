return {
  "folke/noice.nvim",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "40%",
          height = "50%",
        },
      },
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
    },
    presets = {
      lsp_doc_border = true,
      bottom_search = false,
      inc_rename = true,
    },
  },
}
