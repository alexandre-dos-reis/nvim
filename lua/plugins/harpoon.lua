return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    -- Show list in telescope
    vim.keymap.set(
      "n",
      "<leader>hh",
      -- toggle_telescope(harpoon:list())
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end
    )

    -- Show list in telescope
    local keys = {
      ["j"] = 1,
      ["k"] = 2,
      ["l"] = 3,
      [";"] = 4,
    }

    for key, numb in pairs(keys) do
      -- Select harpooned files
      vim.keymap.set("n", ("<leader>" .. key), function()
        harpoon:list():select(numb)
      end)

      -- Add or Replace to harpooned files
      vim.keymap.set("n", ("<leader>h" .. key), function()
        harpoon:list():replace_at(numb)
      end)
    end
  end,
}
