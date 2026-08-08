return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "LazyGit",
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_winblend = 1 -- transparência
    vim.g.lazygit_floating_window_scaling_factor = 1.0
    vim.g.lazygit_use_neovim_remote = true
  end,
}
