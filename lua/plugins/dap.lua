return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")

            require("dapui").setup()
            require("dap-go").setup()
            require("dap-python").setup("uv")

            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
            vim.keymap.set("n", "<space>do", dap.attach)
            vim.keymap.set("n", "<space>dc", function()
                dap.close()
                ui.close()
            end)

            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)
            vim.keymap.set("n", "<F12>", dap.restart)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
    -- keys = {
    --     { "<leader>b",  function() require('dap').toggle_breakpoint() end,              desc = "dap: toggle breakpoint" },
    --     { "<leader>gb", function() require('dap').run_to_cursor() end,                  desc = "dap: run to cursor" },
    --     { "<leader>do", function() require('dap').attach() end,                         desc = "dap: attach" },
    --     { "<leader>dc", function()
    --         require('dap').close()
    --         require('dapui').close()
    --     end,                                                                            desc = "dap: close" },
    --     { "<leader>?",  function() require('dapui').eval(nil, { enter = true }) end,    desc = "dap: eval" },
    --     { "<F1>",       function() require('dap').continue() end,                       desc = "dap: continue" },
    --     { "<F2>",       function() require('dap').step_into() end,                      desc = "dap: step into" },
    --     { "<F3>",       function() require('dap').step_over() end,                      desc = "dap: step over" },
    --     { "<F4>",       function() require('dap').step_out() end,                       desc = "dap: step out" },
    --     { "<F5>",       function() require('dap').step_back() end,                      desc = "dap: step back" },
    --     { "<F12>",      function() require('dap').restart() end,                        desc = "dap: restart" },
    -- },
}
