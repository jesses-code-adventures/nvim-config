local path = vim.fn.expand("~/coding/personal/bruno.nvim")

vim.filetype.add({
    extension = {
        bru = "bruno",
    },
})

return {
    {
        "bruno",
        name = "bruno",
        enabled = false,
        lazy = false,
        dir = path,
        dev = false,
        build = ":TSUpdate",
        config = function()
            require("bruno").setup({ debug = true })
        end,
    },
}
