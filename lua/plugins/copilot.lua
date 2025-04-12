return {
    {
        "zbirenbaum/copilot.lua",
        name = "copilot",
        cmd = "Copilot",
        event = "InsertEnter",
        enabled = false,
        config = function()
            Copilot = require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 25,
                    keymap = {
                        -- TODO: update this to be a nicer keymap
                        accept = "<C-Space>",
                        dismiss = "<C-n>",
                        accept_word = false,
                        accept_line = false,
                        next = false,
                        prev = false,
                    },
                    filetypes = {
                        ["*"] = true,
                        help = false,
                        gitrebase = false,
                    },
                },
            })
        end,

    }
}
