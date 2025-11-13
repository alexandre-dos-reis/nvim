local linters = { eslint = "eslint_d", oxlint = "oxlint", biome = "biomejs" }

local config_files_by_linters = {
  [linters.eslint] = {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  },
  [linters.oxlint] = { ".oxlintrc.json" },
  [linters.biome] = { "biome.json", "biome.jsonc" },
}

local js_linters = { linters.eslint, linters.oxlint, linters.biome }

local linters_by_ft = {
  javascript = js_linters,
  typescript = js_linters,
  javascriptreact = js_linters,
  typescriptreact = js_linters,
}

-- This resolve the linter name based on the project config file
local resolve_linter = function(buffer, file)
  local ft = vim.bo[buffer].ft

  if ft ~= "" or file ~= "" then
    local linters_table = linters_by_ft[ft]

    for _, _linter in pairs(linters_table) do
      local found = vim.fs.find(config_files_by_linters[_linter], { upward = true, path = file })
      if not vim.tbl_isempty(found) then
        return _linter
      end
    end
  end
  return nil
end

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = linters_by_ft

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function(e)
        local ft = vim.bo[e.buf].ft

        if linters_by_ft[ft] == nil then
          return
        end

        lint.try_lint(resolve_linter(e.buf, e.file))
      end,
    })

    vim.keymap.set("n", "<leader>lt", function()
      local buf = vim.api.nvim_get_current_buf()
      local linter_resolved = resolve_linter(buf, vim.api.nvim_buf_get_name(buf))

      if linter_resolved ~= nil then
        print("󰦕  Lint launched with : " .. linter_resolved)
      end
      lint.try_lint(linter_resolved)
    end, { desc = "Trigger linting for current file." })

    vim.keymap.set("n", "<leader>lp", function()
      local running_linters = require("lint").get_running()
      if #running_linters == 0 then
        print("󰦕  No linters running.")
      end
      print("󱉶  linters running: " .. table.concat(linters, ", "))
    end, { desc = "Get the current running linters for the current buffer" })
  end,
}
