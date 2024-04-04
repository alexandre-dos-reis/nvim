return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  },
  opts = function()
    local c = require("solarized-osaka.colors").setup()

    local bg = c.base02

    -- https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline/config.lua#L274
    return {
      options = {
        mode = "tabs",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
      highlights = {
        fill = {
          bg = bg,
        },
        group_separator = {
          bg = bg,
        },
        group_label = {
          fg = bg,
        },
        separator_selected = {
          fg = bg,
        },
        separator_visible = {
          fg = bg,
        },
        separator = {
          fg = bg,
        },
        tab_separator = {
          fg = bg,
        },
        tab_separator_selected = {
          fg = bg,
        },
        offset_separator = {
          bg = bg,
        },
      },
    }
  end,
}
