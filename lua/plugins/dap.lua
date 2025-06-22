return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui
    {
      'leoluz/nvim-dap-go',
      lazy = true,
    },
    {
      'mfussenegger/nvim-dap-python',
      lazy = true,
    },
  },
  keys = {
    { "<leader>b",  function() require("dap").toggle_breakpoint() end, { desc = "nvim-dap toggle breakpoint" } },
    { "<leader>do", function() require("dapui").toggle() end,          { desc = "nvim-dap toggle" } },
    { "<F1>",       function() require("dap").continue() end,          { desc = "nvim-dap continue" } },
    { "<F2>",       function() require("dap").step_into() end,         { desc = "nvim-dap step into" } },
    { "<F3>",       function() require("dap").step_over() end,         { desc = "nvim-dap step over" } },
    { "<F4>",       function() require("dap").step_out() end,          { desc = "nvim-dap step out" } },
    { "<F5>",       function() require("dap").step_back() end,         { desc = "nvim-dap step back" } },
    { "<F11>",      function() require("dap").terminate() end,           { desc = "nvim-dap restart" } },
    { "<F12>",      function() require("dap").restart() end,           { desc = "nvim-dap restart" } },
    { "<leader>?",  function() require("dapui").eval() end,            { desc = "nvim-dap eval" } },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          elements = { "console", "repl" },
          size = 10,
          position = "bottom",
        },
        {
          elements = {
            { id = "scopes", size = 0.8 },
            { id = "breakpoints", size = 0.2 },
          },
          size = 40,
          position = "left",
        },
      },
    })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-go').setup {
      delve = {},
    }
    require("dap-python").setup("uv")
  end,
}
