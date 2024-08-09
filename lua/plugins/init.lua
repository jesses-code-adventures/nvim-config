return {
    "tpope/vim-sleuth",
    {
        name = "plenary",
        "nvim-lua/plenary.nvim",
        lazy = true
    },
    { "https://github.com/nvim-tree/nvim-web-devicons", lazy = false, event = "VimEnter" },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        name = "neodev",
        "folke/neodev.nvim",
        lazy = true
    },
    {
        "folke/trouble.nvim",
        name = "trouble",
        lazy = false,
        keys = {
            { "<leader>xx", function() require("trouble").toggle() end,                        desc = "toggle trouble" },
            { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "trouble workspace diagnostics" },
            { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,  desc = "trouble document diagnostics" },
            { "<leader>xq", function() require("trouble").toggle("quickfix") end,              desc = "trouble quickfix list" },
            { "<leader>xl", function() require("trouble").toggle("loclist") end,               desc = "trouble location list" },
            { "gR",         function() require("trouble").toggle("lsp_references") end,        desc = "trouble lsp references" },
        }
    },
}
