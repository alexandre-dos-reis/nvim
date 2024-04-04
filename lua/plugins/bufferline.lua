return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  },
  opts = function()
    local c = require("solarized-osaka.colors").setup()

    local background = c.base02
    local unselectedBg = c.base03
    local unselectedFg = c.base01
    -- local red = "#ff0000"

    -- https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline/config.lua#L274
    return {
      options = {
        mode = "tabs",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
      highlights = {
        background = {
          fg = unselectedFg,
          bg = unselectedBg,
        },
        fill = {
          bg = background,
        },
        group_separator = {
          bg = background,
        },
        group_label = {
          fg = background,
        },
        separator_selected = {
          fg = background,
        },
        separator_visible = {
          fg = background,
          bg = unselectedBg,
        },
        separator = {
          fg = background,
          bg = unselectedBg,
        },
        tab_separator = {
          fg = background,
          bg = unselectedBg,
        },
        tab_separator_selected = {
          fg = background,
        },
        offset_separator = {
          bg = background,
        },
        modified = {
          bg = unselectedBg,
        },
      },
    }
  end,
}
