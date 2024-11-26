local dev = false
local path = vim.fn.expand("~/coding/personal/uuid.nvim")

return {
    {
        "timwmillard/uuid.nvim",
        name = "uuid",
        dir = dev and path or nil,
        dev = dev,
        enabled = true,
        keys = {
            { "<leader>mid", function() require('uuid').newV4() end, mode = "n", desc = "New UUID in paste buffer" },
        },
    }
}
