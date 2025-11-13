local linters = {
  eslint = "eslint_d",
  biome = "biomejs",
}

local for_all_js_ft = { default = linters.eslint, others = { linters.biome } }

local mult_linters_by_ft = {
  javascript = for_all_js_ft,
  typescript = for_all_js_ft,
  javascriptreact = for_all_js_ft,
  typescriptreact = for_all_js_ft,
}

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre" },
  config = function()
    local lint = require("lint")

    local linters_by_ft = {}

    for ft, config in pairs(mult_linters_by_ft) do
      linters_by_ft[ft] = { config.default }
    end

    -- Default
    lint.linters_by_ft = linters_by_ft

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function(e)
        -- local ft = vim.bo[e.buf].ft
        --
        -- vim.fs.find("", { upward = true })

        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      if #require("lint").get_running() == 0 then
        return "󰦕"
      end
      return "󱉶 " .. table.concat(linters, ", ")
    end)
  end,
}
