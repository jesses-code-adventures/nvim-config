local dev_path = vim.fn.expand("~/coding/personal/dotenv.nvim") -- for local dev, pass this to dir

return {
    {
        "jesses-code-adventures/dotenv.nvim",
        dev=false,
        config = function()
            require("dotenv").setup()
        end,
    }
}
