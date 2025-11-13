local linters = { eslint = "eslint_d", oxlint = "oxlint" }

-- TODO: For the moment nvim-lint run every linters for one ft.
-- Try to find the default linter config file and use it, then the others, ...
-- and pass it to `try_lint`
-- See the linters branch
local js_linters = { linters.eslint, linters.oxlint }

local linters_by_ft = {
  javascript = js_linters,
  typescript = js_linters,
  javascriptreact = js_linters,
  typescriptreact = js_linters,
}

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = linters_by_ft

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    local lint_progress = function()
      local running_linters = require("lint").get_running()
      if #running_linters == 0 then
        return "󰦕  No linters running."
      end
      return "󱉶  linters running: " .. table.concat(linters, ", ")
    end

    vim.keymap.set("n", "<leader>lt", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file." })

    vim.keymap.set("n", "<leader>lp", function()
      print(lint_progress())
    end, { desc = "Get the current running linters for the current buffer" })
  end,
}
