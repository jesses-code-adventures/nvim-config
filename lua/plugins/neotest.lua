return {
  "nvim-neotest/neotest",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" }
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang")({}),
      },
    })
  end,
  keys = {
    -- TODO: fix this
    {"<leader>tt", function() require("neotest").run.run({strategy = "dap"}) end, mode = {"n", "v"}, desc = "neotest: test this function"},
    {"<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, mode = {"n", "v"}, desc = "neotest: test all functions in file"},
    {"<leader>ts", function() require("neotest").summary.open() end, mode = {"n", "v"}, desc = "neotest: open test summary"},
  },
}
