return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    vim.keymap.set("n", "<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Show harpoon list" })

    local keys = {
      ["j"] = 1,
      ["k"] = 2,
      ["l"] = 3,
      [";"] = 4,
    }

    for key, numb in pairs(keys) do
      vim.keymap.set("n", ("<leader>" .. key), function()
        harpoon:list():select(numb)
      end, { desc = "Select harpooned file # " .. numb })

      vim.keymap.set("n", ("<leader>h" .. key), function()
        harpoon:list():replace_at(numb)
      end, { desc = "Append current file to harpoon file # " .. numb })
    end
  end,
}
