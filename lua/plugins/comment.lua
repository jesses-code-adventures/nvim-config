return {
    {
        'numToStr/Comment.nvim',
        name = "comment",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("Comment").setup()
        end
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        ft = { "templ", "tsx", "jsx", "markdown", "svelte", "typescript", "javascript" },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPost", "BufNewFile" },
        opts = {}
    }
}
