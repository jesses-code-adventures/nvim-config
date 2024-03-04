return {
    {
        "folke/trouble.nvim",
        name = "trouble",
        lazy = false,
        config = function()
            require("trouble").setup {
                position = "right",
                width = 30,
            }
        end,
        dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
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
