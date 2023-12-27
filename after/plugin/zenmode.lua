vim.keymap.set("n", "<leader>zn", function()
    require("zen-mode").close()
    vim.cmd("LineNumberIntervalDisable")
    vim.cmd("lua ColorMyPencils()")
end)

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
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
    }
    require("zen-mode").open()
    vim.g.line_number_interval = 10
    vim.cmd("LineNumberIntervalEnable")
end)
