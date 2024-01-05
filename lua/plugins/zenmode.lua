return({
    "folke/zen-mode.nvim",
    name="zen-mode",
    dependencies={
        "IMOKURI/line-number-interval.nvim"
    },
    opts={
        window = {
            width = 80,
            options = {
                cursorcolumn=false,
            }
        },
        plugins = {
            options = {
                enabled = true,
                showcmd = false,
                cmdheight = 1,

            },
            tmux = { enabled = false },
        }
    },
    keys={
        {
            "<leader>zz",
            function()
                Zen_mode.setup()
                Zen_mode.open()
                vim.g.line_number_interval = 10
                vim.cmd("LineNumberIntervalEnable")
            end,
            desc="launch zen mode"
        },
        {
            "<leader>zn",
            function()
                Zen_mode.close()
                vim.g.line_number_interval=1
            end,
            desc="close zen mode"
        }
    },
    config=function()
        Zen_mode = require("zen-mode")
    end
})
