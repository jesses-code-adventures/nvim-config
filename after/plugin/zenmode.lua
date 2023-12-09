vim.keymap.set("n", "<leader>zZ", function()
    require("zen-mode").setup {
        window = {
            width = 80,
            options = {
            }
        },
        plugins = {
            tmux = {enabled = false}
        }
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
end)


vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 100,
            options = {
                signcolumn="no",
                cursorcolumn=false,
                foldcolumn="0"
            }
        },
        plugins = {
            options = {
                enabled = true,
                ruler = false,
                showcmd = false,
                cmdheight = 1,

            },
            tmux = { enabled = true },
        }
    }
    require("zen-mode").toggle()
    vim.wo.wrap = true
    vim.wo.number = true
    vim.wo.rnu = true
end)
