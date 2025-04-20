local work_dir = vim.fn.expand("~/coding/personal/bruno.nvim")
local dev = true

return {
  "jesses-code-adventures/bruno.nvim",
  dir = dev and work_dir or nil,
  dev = dev,
  enabled = false,
  opts = {
    _debug = false,
  },
  keys = {
    { "<leader>r", function() require("bruno").query_current_file(); end, mode = "n", desc = "Run the query in the current .bru file in a scratch buffer." },
  },
  lazy = false,
}

