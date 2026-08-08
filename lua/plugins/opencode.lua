return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
  },
  config = function()
    vim.g.opencode_opts = {
      -- opções padrão são boas pra começar
    }

    local oc = require("opencode")
    vim.keymap.set({ "n", "x" }, "<leader>oa", function() oc.ask() end, { desc = "OpenCode ask" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() oc.select() end, { desc = "OpenCode select" })
    vim.keymap.set({ "n", "x" }, "<leader>oc", function() oc.toggle() end, { desc = "OpenCode TUI" })
  end,
}
