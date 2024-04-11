return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- enabled = false,
  opts = function()
    local colors = require("solarized-osaka.colors").setup()

    local theme = {
      normal = {
        a = { fg = colors.base03, bg = colors.blue, gui = "bold" },
        b = { fg = colors.base03, bg = colors.base1 },
        c = { fg = colors.base1, bg = colors.base02 },
      },
      insert = { a = { fg = colors.base03, bg = colors.warning, gui = "bold" } },
      visual = { a = { fg = colors.base03, bg = colors.magenta, gui = "bold" } },
      replace = { a = { fg = colors.base03, bg = colors.red, gui = "bold" } },
      inactive = {
        a = { fg = colors.base0, bg = colors.base02, gui = "bold" },
        b = { fg = colors.base03, bg = colors.base00 },
        c = { fg = colors.base01, bg = colors.base02 },
      },
    }

    return {
      options = {
        theme = theme,
        globalstatus = true,
      },
    }
  end,
}
