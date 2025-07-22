-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Comando para copiar o caminho completo do arquivo atual
vim.api.nvim_create_user_command("CopyFilePath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("File Path Copied" .. vim.fn.expand("%:p"))
end, {})

-- Keymap para o comando
vim.keymap.set("n", "<leader>cp", "<cmd>CopyFilePath<CR>", { desc = "Copy File Path in Buffer" })
