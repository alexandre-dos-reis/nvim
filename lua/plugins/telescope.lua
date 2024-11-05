return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})

      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
        },
        extensions = {
          file_browser = {
            grouped = true,
            initial_mode = "normal",
            hijack_netrw = true,
            layout_strategy = "flex",
            no_ignore = true,
            mappings = {
              ["n"] = {
                ["c"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["o"] = fb_actions.toggle_hidden,
                ["<C-u>"] = function(prompt_bufnr)
                  for _ = 1, 10 do
                    actions.move_selection_previous(prompt_bufnr)
                  end
                end,
                ["<C-d>"] = function(prompt_bufnr)
                  for _ = 1, 10 do
                    actions.move_selection_next(prompt_bufnr)
                  end
                end,
                ["<PageUp>"] = actions.preview_scrolling_up,
                ["<PageDown>"] = actions.preview_scrolling_down,
              },
            },
          },
        },
      })
      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      require("telescope").load_extension("file_browser")

      vim.keymap.set("n", "<space>e", ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>")
    end,
  },
}
