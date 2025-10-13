return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    cond = function()
      if vim.fn.executable("vscode-json-languageserver") == 1 or vim.fn.executable("yaml-language-server") == 1 then
        return true
      else
        return false
      end
    end,
  },
}
