-- ~/.config/nvim/lua/plugins/surround.lua
-- nvim-surround v4: keymaps via <Plug> mappings, not setup()
return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  init = function()
    -- Disable default visual mappings (we remap to gs/gS to avoid Flash.nvim conflict)
    vim.g.nvim_surround_no_visual_mappings = true
  end,
  keys = {
    -- Visual mode: "gs" instead of "S" (Flash.nvim uses "S" for Treesitter nav)
    { "gs", "<Plug>(nvim-surround-visual)", mode = "x", desc = "Surround (visual)" },
    { "gS", "<Plug>(nvim-surround-visual-line)", mode = "x", desc = "Surround line (visual)" },
  },
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        ["'"] = {
          add = { "'", "'" },
        },
        ['"'] = {
          add = { '"', '"' },
        },
        -- HTML/XML tags
        ["t"] = {
          add = function()
            local result = vim.fn.input("Tag: ")
            if result ~= "" then
              return { { "<" .. result .. ">" }, { "</" .. result:match("^%S+") .. ">" } }
            end
          end,
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
