-- local path = "~/.config/local-plugs/dotenv.nvim"
--
-- path = vim.fn.expand(path)
--
-- if not vim.loop.fs_stat(path) then
--     error("dotenv.nvim not found...")
-- end
--
-- return {
--     {
--         "dotenv",
--         dir = path,
--         dev=true,
--         config = function()
--             vim.opt.runtimepath:append(vim.fn.expand(path))
--             require("dotenv").setup()
--         end,
--         lazy=false
--     }
-- }


local dev_path = vim.fn.expand("~/coding/personal/dotenv.nvim")

return {
    {
        "jesses-code-adventures/dotenv.nvim",
        dir=dev_path,
        dev=true,
        config = function()
            require("dotenv").setup()
        end,
    }
}
