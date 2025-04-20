local dev = false
local path = vim.fn.expand("~/coding/personal/dotenv.nvim") -- for local dev, pass this to dir

return {
    "jesses-code-adventures/dotenv.nvim",
    dir = dev and path or nil,
    dev = dev,
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        overrides = { ".env", ".local.env", ".env.local", ".local.mine.env", ".env.mine" },
    },
}
