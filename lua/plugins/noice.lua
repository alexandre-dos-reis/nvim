return {
  "folke/noice.nvim",
  opts = function(_, opts)
    -- Remove message on save
    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    })

    -- Remove message when no info is available
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })

    -- Place the cmdline popup at the center
    opts.views = {
      cmdline_popup = {
        position = {
          row = "40%",
          height = "50%",
        },
      },
    }

    opts.preset = {
      lsp_doc_border = true,
      bottom_search = false,
      inc_rename = true,
    }
  end,
}
