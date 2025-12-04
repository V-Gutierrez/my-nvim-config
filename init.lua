-- bootstrap lazy.nvim, LazyVim and your plugins
-- Detectar se está rodando no VSCode e carregar config apropriada
if vim.g.vscode then
  local vscode_init = vim.fn.stdpath("config") .. "/vscode-init.lua"
  dofile(vscode_init)
else
  require("config.lazy")
end

