local path = vim.fn.expand("~/coding/personal/manu.nvim")

if not vim.loop.fs_stat(path) then
    return {}
end

vim.opt.runtimepath:append(path)

return {
    {
        "manu",
        dir = path,
        dev=true,
        enabled=false,
        config = function()
            local manu = require("manu")
            manu.setup()
            vim.keymap.set("n", "<leader>mo", function() manu.open_chat() end, {})
            vim.keymap.set("n", "<leader>mr", function() manu.replace_and_prompt() end, {})
        end,
        lazy=false
    }
}
