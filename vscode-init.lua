-- vscode-init.lua - Configuração minimalista para VSCode Neovim
-- Mantém apenas nvim-surround, diagnostic styling e keymaps essenciais

-- 1. Verificação VSCode
if not vim.g.vscode then
  return
end

-- Confirmar que o vscode-init.lua foi carregado
vim.notify("VSCode Neovim config loaded", vim.log.levels.INFO)

-- 2. Bootstrap Lazy.nvim (minimal)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Carregar nvim-surround
require("lazy").setup({
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      local M = require("nvim-surround.config")
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "gs",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
        surrounds = {
          -- Configurações mais intuitivas para aspas
          ["'"] = {
            add = { "'", "'" },
            find = function()
              return M.get_selection({ motion = "a'" })
            end,
            delete = "^(.)().-(.)()$",
          },
          ['"'] = {
            add = { '"', '"' },
            find = function()
              return M.get_selection({ motion = 'a"' })
            end,
            delete = "^(.)().-(.)()$",
          },
          -- Facilitar uso com HTML/XML tags
          ["t"] = {
            add = function()
              local config = require("nvim-surround.config")
              local result = config.get_input("Tag: ")
              if result then
                return { { "<" .. result .. ">" }, { "</" .. result:match("^%S+") .. ">" } }
              end
            end,
            find = "<[^<>]*>.-</%w*>",
            delete = "^(<[^<>]*>)().-(</%w*>)()$",
          },
          -- Markdown code blocks
          ["c"] = {
            add = { "```", "```" },
          },
          -- Parênteses com espaços
          ["("] = { add = { "( ", " )" } },
          ["["] = { add = { "[ ", " ]" } },
          ["{"] = { add = { "{ ", " }" } },
        },
      })
    end,
  },
}, {
  ui = {
    border = "none",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- 4. Opções Vim básicas
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- case-sensitive if uppercase present
vim.opt.updatetime = 300 -- faster diagnostic updates
vim.opt.list = false -- hide whitespace characters

-- 5. Diagnostic config
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
    virt_text_pos = "eol",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Diagnostic signs (remove white dot for Info)
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnostic colors (more visible)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff6b6b", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#feca57", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#48cae4" })
    vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#95e1d3" })
  end,
})

-- Yank visual feedback (highlight yanked text briefly)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- 6. Keymaps custom
vim.api.nvim_create_user_command("CopyFilePath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("File Path Copied " .. vim.fn.expand("%:p"))
end, {})

vim.keymap.set("n", "<leader>cp", "<cmd>CopyFilePath<CR>", { desc = "Copy File Path in Buffer" })

-- ============================================================================
-- 7. KEYMAPS: LazyVim → VSCode Equivalents
-- ============================================================================
-- Total: 26 keymaps mapeados do LazyVim para comandos equivalentes do VSCode
--
-- NOTA: f/t/F/T agora usam motions nativos do Vim (vf, vt, yf, yt funcionam!)
-- Use 's' para busca rápida no VSCode em vez de f/t

-- Flash Navigation → VSCode Search/Navigation (7 keymaps)
vim.keymap.set("n", "s", function()
  vim.fn.VSCodeNotify("actions.find")
end, { desc = "Forward Search (Flash alternative)" })

vim.keymap.set("n", "/", function()
  vim.fn.VSCodeNotify("actions.find")
end, { desc = "Forward Search (Flash alternative)" })

vim.keymap.set("n", "S", function()
  vim.fn.VSCodeNotify("workbench.action.gotoSymbol")
end, { desc = "Go to Symbol (Flash Treesitter)" })

vim.keymap.set("n", "r", function()
  vim.fn.VSCodeNotify("workbench.action.quickOpen")
end, { desc = "Quick Open (Remote Flash)" })

vim.keymap.set("n", "R", function()
  vim.fn.VSCodeNotify("workbench.action.showAllSymbols")
end, { desc = "Go to Symbol in Workspace (Treesitter Search)" })

-- Flash char motions → Native Vim motions (f/t/F/T work in visual mode)
-- NOTA: Removidos mappings de f/t/F/T para permitir uso nativo em visual mode
-- Agora vf/vt/vF/vT funcionam corretamente como motions do Vim
-- Use 's' para busca rápida se precisar de find do VSCode

-- Note: 'e' (end of word) is native Vim motion, works automatically
-- Note: 'f/t/F/T' agora são motions nativos do Vim (funcionam com v/y/d/c)

vim.keymap.set("n", ";", function()
  vim.fn.VSCodeNotify("editor.action.nextMatchFindAction")
end, { desc = "Repeat last find" })

vim.keymap.set("n", ",", function()
  vim.fn.VSCodeNotify("editor.action.previousMatchFindAction")
end, { desc = "Repeat find reverse" })

-- Window Navigation → Editor Groups (6 keymaps)
vim.keymap.set("n", "<C-h>", function()
  vim.fn.VSCodeNotify("workbench.action.navigateLeft")
end, { desc = "Navigate Left" })

vim.keymap.set("n", "<C-j>", function()
  vim.fn.VSCodeNotify("workbench.action.navigateDown")
end, { desc = "Navigate Down" })

vim.keymap.set("n", "<C-k>", function()
  vim.fn.VSCodeNotify("workbench.action.navigateUp")
end, { desc = "Navigate Up" })

vim.keymap.set("n", "<C-l>", function()
  vim.fn.VSCodeNotify("workbench.action.navigateRight")
end, { desc = "Navigate Right" })

vim.keymap.set("n", "<leader>ww", function()
  vim.fn.VSCodeNotify("workbench.action.focusNextGroup")
end, { desc = "Other Window" })

vim.keymap.set("n", "<leader>wd", function()
  vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
end, { desc = "Delete Window" })

-- Buffer Navigation → Tabs (4 keymaps)
vim.keymap.set("n", "<leader>bn", function()
  vim.fn.VSCodeNotify("workbench.action.nextEditor")
end, { desc = "Next Buffer/Editor" })

vim.keymap.set("n", "<leader>bp", function()
  vim.fn.VSCodeNotify("workbench.action.previousEditor")
end, { desc = "Previous Buffer/Editor" })

vim.keymap.set("n", "<leader>bb", function()
  vim.fn.VSCodeNotify("workbench.action.quickOpen")
end, { desc = "Buffer Picker" })

vim.keymap.set("n", "<leader>bd", function()
  vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
end, { desc = "Delete Buffer" })

-- LSP Diagnostics → VSCode Problems (4 keymaps)
vim.keymap.set("n", "]d", function()
  vim.fn.VSCodeNotify("editor.action.marker.nextInFiles")
end, { desc = "Next Diagnostic" })

vim.keymap.set("n", "[d", function()
  vim.fn.VSCodeNotify("editor.action.marker.prevInFiles")
end, { desc = "Previous Diagnostic" })

vim.keymap.set("n", "]e", function()
  vim.fn.VSCodeNotify("editor.action.marker.nextInFiles")
end, { desc = "Next Error" })

vim.keymap.set("n", "[e", function()
  vim.fn.VSCodeNotify("editor.action.marker.prevInFiles")
end, { desc = "Previous Error" })

-- LSP Navigation → Code Navigation (2 keymaps)
vim.keymap.set("n", "gd", function()
  vim.fn.VSCodeNotify("editor.action.revealDefinition")
end, { desc = "Go to Definition" })

vim.keymap.set("n", "gr", function()
  vim.fn.VSCodeNotify("editor.action.goToReferences")
end, { desc = "Go to References (Peek View)" })

-- Git Commands (1 keymap)
vim.keymap.set("n", "<leader>gg", function()
  vim.fn.VSCodeNotify("workbench.view.scm")
end, { desc = "Git View (LazyGit alternative)" })

-- NOTA: gs e gS continuam sendo usados pelo nvim-surround no visual mode

