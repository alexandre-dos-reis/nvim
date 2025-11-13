return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    local js_config = { "eslint_d" }

    lint.linters_by_ft = {
      javascript = js_config,
      typescript = js_config,
      javascriptreact = js_config,
      typescriptreact = js_config,
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    local lint_progress = function()
      local linters = require("lint").get_running()
      print(linters)
      if #linters == 0 then
        return "󰦕"
      end
      return "󱉶 " .. table.concat(linters, ", ")
    end

    vim.keymap.set("n", "<leader>lt", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file." })

    vim.keymap.set("n", "<leader>lp", function()
      print(lint_progress())
    end, { desc = "Get the current running linters for the current buffer" })
  end,
}
