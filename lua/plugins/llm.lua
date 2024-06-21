return {
    {
        "https://github.com/melbaldove/llm.nvim",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
            require("llm")
            vim.keymap.set("n", "<leader>ln", function() require("llm").prompt({ replace = false, service = "openai" }) end)
            vim.keymap.set("v", "<leader>ln", function() require("llm").prompt({ replace = false, service = "openai" }) end)
            vim.keymap.set("v", "<leader>lr", function() require("llm").prompt({ replace = true, service = "openai" }) end)
        end,
        lazy=false
    }
}
