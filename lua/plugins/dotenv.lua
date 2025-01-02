local dev_path = vim.fn.expand("~/.config/local-plugs/dotenv.nvim") -- for local dev, pass this to dir

return {
    {
        "jesses-code-adventures/dotenv.nvim",
        opts={
            overrides={".env", ".local.env", ".env.local", ".local.mine.env", ".env.mine"},
        },
    }
}
