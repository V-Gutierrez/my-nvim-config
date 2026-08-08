-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Comando para copiar o caminho completo do arquivo atual
vim.api.nvim_create_user_command("CopyFilePath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("File Path Copied " .. vim.fn.expand("%:p"))
end, {})

-- Keymap para o comando
vim.keymap.set("n", "<leader>cP", "<cmd>CopyFilePath<CR>", { desc = "Copy File Path in Buffer" })

-- ============================================================================
-- PLUGIN KEYBINDINGS REFERENCE
-- ============================================================================
--
-- FLASH.NVIM (Navegação Inteligente):
-- • S       = Flash Treesitter (navegação semântica no normal/visual)
-- • s       = Flash jump (pular para label)
-- • /       = Flash search (busca com labels)
--
-- NVIM-SURROUND (Texto entre delimitadores):
-- • ys{motion}{char} = adicionar surround (ex: ysiw" = aspas na palavra)
-- • ds{char}         = deletar surround (ex: ds" = remover aspas)
-- • cs{old}{new}     = mudar surround (ex: cs"' = aspas duplas → simples)
-- • gs               = adicionar surround no VISUAL (mudança: era "S")
-- • gS               = adicionar surround linha no VISUAL
--
-- DIAGNOSTICS & LSP:
-- • ]d / [d         = próximo/anterior diagnostic
-- • ]e / [e         = próximo/anterior error
-- • ]w / [w         = próximo/anterior warning
-- • <leader>cd      = mostrar diagnostic em float
--
-- NOTA: Mudamos surround de "S" → "gs" para evitar conflito com Flash!
-- NOTA: Removido ponto branco dos Info diagnostics para interface mais limpa
