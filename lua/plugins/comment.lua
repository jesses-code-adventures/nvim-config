return {
    {
        'numToStr/Comment.nvim',
        name = "comment",
        lazy = false,
        config = function()
            require("Comment").setup()
        end
    },
}
