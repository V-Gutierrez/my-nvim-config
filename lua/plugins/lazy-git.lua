return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "LazyGit",
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Abrir LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_winblend = 0 -- transparência
    vim.g.lazygit_floating_window_scaling_factor = 1.0
    vim.g.lazygit_use_neovim_remote = true
  end,
}
