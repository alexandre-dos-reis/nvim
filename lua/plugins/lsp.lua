return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
    lspconfig.lua_ls.setup({}) -- lua
    lspconfig.ts_ls.setup({}) -- typescript

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  end,
}
