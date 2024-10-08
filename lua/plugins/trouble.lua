return {
    {
        "folke/trouble.nvim",
        name = "trouble",
        config = function()
            require("trouble").setup {
                position = "bottom",
                width = 30,
            }
        end,
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "toggle trouble" },
            { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "trouble workspace diagnostics" },
            { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,  desc = "trouble document diagnostics" },
            { "<leader>xq", function() require("trouble").toggle("quickfix") end,              desc = "trouble quickfix list" },
            { "<leader>xl", function() require("trouble").toggle("loclist") end,               desc = "trouble location list" },
            { "gR",         function() require("trouble").toggle("lsp_references") end,        desc = "trouble lsp references" },
        }
    },
}
