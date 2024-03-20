return {
    {
        'folke/neoconf.nvim',
        name = "neoconf",
        lazy = false,
        config = function()
            require("neoconf").setup()
        end
    },
}
