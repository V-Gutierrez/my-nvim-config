return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Spectre",
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").toggle()
      end,
      desc = "Spectre (search & replace)",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Spectre search word",
    },
  },
  opts = {
    color_devicons = true,
    open_cmd = "noswapfile vnew",
    live_update = true,
    mapping = {
      ["toggle_line"] = {
        map = "dd",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle line",
      },
      ["enter_file"] = {
        map = "fe",
        cmd = "<cmd>lua require('spectre').open_file()<CR>",
        desc = "open file",
      },
      ["send_to_qf"] = {
        map = "fq",
        cmd = "<cmd>lua require('spectre').send_to_qf()<CR>",
        desc = "send to quickfix",
      },
      ["replace_confirm"] = {
        map = "fc",
        cmd = "<cmd>lua require('spectre').replace_confirm()<CR>",
        desc = "replace confirm",
      },
      ["replace_all"] = {
        map = "fa",
        cmd = "<cmd>lua require('spectre').replace_all()<CR>",
        desc = "replace all",
      },
    },
  },
}
