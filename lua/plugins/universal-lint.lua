return {
  -- Configuração universal de diagnósticos para todas as linguagens
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configurar diagnósticos para aparecer automaticamente no modo normal
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

      -- Mostrar diagnósticos automaticamente quando o cursor parar
      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        group = vim.api.nvim_create_augroup("auto_diagnostic", { clear = true }),
        callback = function()
          vim.diagnostic.open_float(nil, { 
            focus = false,
            scope = "cursor",
          })
        end,
      })

      -- Tempo mais rápido para mostrar diagnósticos
      vim.opt.updatetime = 300
    end,
  },

  -- Configuração universal de linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Configurar linters para todas as linguagens suportadas
      lint.linters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "eslint_d", "eslint" },
        typescript = { "eslint_d", "eslint" },
        javascriptreact = { "eslint_d", "eslint" },
        typescriptreact = { "eslint_d", "eslint" },
        vue = { "eslint_d", "eslint" },
        svelte = { "eslint_d", "eslint" },
        astro = { "eslint_d", "eslint" },
        
        -- Python
        python = { "ruff", "flake8", "pylint" },
        
        -- Lua
        lua = { "luacheck" },
        
        -- Shell
        bash = { "shellcheck" },
        sh = { "shellcheck" },
        zsh = { "shellcheck" },
        
        -- Go
        go = { "golangcilint", "revive" },
        
        -- Rust
        rust = { "clippy" },
        
        -- C/C++
        c = { "cppcheck", "cpplint" },
        cpp = { "cppcheck", "cpplint" },
        
        -- Java
        java = { "checkstyle" },
        
        -- PHP
        php = { "phpcs", "psalm" },
        
        -- Ruby
        ruby = { "rubocop" },
        
        -- Docker
        dockerfile = { "hadolint" },
        
        -- YAML
        yaml = { "yamllint" },
        yml = { "yamllint" },
        
        -- JSON
        json = { "jsonlint" },
        
        -- Markdown
        markdown = { "markdownlint" },
        
        -- CSS/SCSS
        css = { "stylelint" },
        scss = { "stylelint" },
        
        -- HTML
        html = { "htmlhint" },
        
        -- Terraform
        terraform = { "tflint" },
        tf = { "tflint" },
        
        -- Ansible
        ansible = { "ansible-lint" },
        
        -- SQL
        sql = { "sqlfluff" },
      }

      -- Função para executar lint automaticamente
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      
      vim.api.nvim_create_autocmd({ 
        "BufEnter", 
        "BufWritePost", 
        "InsertLeave",
        "TextChanged"
      }, {
        group = lint_augroup,
        callback = function()
          -- Só executa lint se houver linters configurados para o filetype atual
          local filetype = vim.bo.filetype
          if lint.linters_by_ft[filetype] then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  -- Ocultar caracteres de espaço em branco
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Desabilitar list mode para ocultar pontos de espaço
      vim.opt.list = false
      vim.opt.listchars = ""
      
      -- Se você quiser mostrar apenas alguns caracteres específicos, descomente e ajuste:
      -- vim.opt.list = true
      -- vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }
    end,
  },

  -- Melhorar a exibição de erros com cores mais visíveis
  {
    "folke/tokyonight.nvim",
    opts = function()
      -- Configurar cores de diagnóstico mais visíveis
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          -- Cores mais visíveis para diagnósticos
          vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff6b6b", bold = true })
          vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#feca57", bold = true })
          vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#48cae4" })
          vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#95e1d3" })
        end,
      })
    end,
  },
}