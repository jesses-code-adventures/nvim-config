local dev = true
local path = vim.fn.expand("~/coding/personal/manu.nvim")

if dev and not vim.loop.fs_stat(path) then
    path = vim.fn.expand("~/coding/manu.nvim")
    if dev and not vim.loop.fs_stat(path) then
        return {}
    end
end

if dev then
    vim.opt.runtimepath:append(path)
end

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
        keys = {
            { "<leader>mo", "<cmd>Manu open_chat <cr>", mode = {"n", "v"}, desc = "Open manu chat" },
            { "<leader>mr", "<cmd>Manu prompt_llm <cr>", mode = {"n", "v"}, desc = "send prompt to chat" },
            { "<leader>md", "<cmd>Manu print_state <cr>", mode = "v", desc = "send prompt to chat" },
        },
        lazy = false
    }
}

