return {
    {
        "zbirenbaum/copilot.lua",
        name = "copilot",
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            {"<C-Space>", mode={"i"}, function() require('copilot.suggestion').accept_line() end, desc="copilot accept suggestion"},
            {"<C-d>", mode={"i"}, function() require('copilot.suggestion').dismiss() end, desc="copilot dismiss suggestion"},
        },
        config = function()
            Copilot = require("copilot").setup({
                suggestion={enabled=false, auto_trigger=true}
            })
        end,

    }
}
