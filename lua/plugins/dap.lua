return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {"leoluz/nvim-dap-go", config = function() require("dap-go").setup() end },
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap-python",
    },
    lazy = true,
    keys = {
        { "<leader>b",  function() require("dap").toggle_breakpoint() end, { desc = "nvim-dap toggle breakpoint" } },
        { "<leader>do", function() require("dap").attach() end,            { desc = "nvim-dap attach" } },
        { "<leader>dc", function()
            require("dap").close()
            require("dap-ui").close()
        end, { desc = "nvim-dap close" } },
        { "<leader>?", function() require("nvim-dap-ui").eval() end, { desc = "nvim-dap eval" } },
        { "<F1>",      function() require("dap").continue() end,     { desc = "nvim-dap continue" } },
        { "<F2>",      function() require("dap").step_into() end,    { desc = "nvim-dap step into" } },
        { "<F3>",      function() require("dap").step_over() end,    { desc = "nvim-dap step over" } },
        { "<F4>",      function() require("dap").step_out() end,     { desc = "nvim-dap step out" } },
        { "<F5>",      function() require("dap").step_back() end,    { desc = "nvim-dap step back" } },
        { "<F12>",     function() require("dap").restart() end,      { desc = "nvim-dap restart" } },
    },
}
