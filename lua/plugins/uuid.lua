local dev = true
local path = vim.fn.expand("~/coding/personal/uuid.nvim")

if not vim.loop.fs_stat(path) then
    return {}
end

return {
    {
        "timwmillard/uuid.nvim",
        name = "uuid",
        dir = dev and path or nil,
        dev = dev,
        enabled = true,
        keys = {
            { "<leader>6", function() require('uuid').newV4() end, mode = "n", desc = "New UUID in paste buffer" },
        },
        lazy = false
    }
}
