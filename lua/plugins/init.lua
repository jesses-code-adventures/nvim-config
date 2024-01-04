return {
    {
        name = "plenary",
        "nvim-lua/plenary.nvim",
        lazy = true
    },
    {
        name = "neoformat",
        "sbdchd/neoformat",
        lazy = false,
    },
    {
        name = "neodev",
        "folke/neodev.nvim",
        lazy = true
    },
    {
        name = "trouble",
        "folke/trouble.nvim",
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
    {
        name = "undotree",
        "mbbill/undotree",
        lazy = false,
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "toggle undotree" }
        }
    },
    {
        'numToStr/Comment.nvim',
        name = "comment",
        lazy = false,
        config = function()
            require("Comment").setup()
        end
    },
}
