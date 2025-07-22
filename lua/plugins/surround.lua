-- ~/.config/nvim/lua/plugins/surround.lua
return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        -- Mudança: "S" → "gs" para evitar conflito com Flash.nvim
        -- Flash.nvim usa "S" para navegação Treesitter no modo visual
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
}
