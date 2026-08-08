return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("kanagawa-dragon")
      end,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      theme = "dragon",
      transparent = false,
      terminalColors = true,
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { bold = true },
      colors = {
        theme = {
          dragon = {
            ui = {
              bg = "#181616",
            },
          },
        },
      },
    },
  },
}
