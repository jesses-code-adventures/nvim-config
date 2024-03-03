return {
    {
        "trying_stuff",
        dir = "~/.config/local-plugs/trying_stuff.nvim",
        dev=true,
        config = function()
            vim.opt.runtimepath:append(',~/.config/local-plugs/trying_stuff.nvim')
            local trying_stuff = require("trying_stuff").setup({
                width = 40,
                height = 20,
            })
            vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>lua require("trying_stuff").toggle()<cr>', { noremap = true, silent = true })
        end,
        lazy=false
    }
}
