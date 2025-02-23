local check_node_installed = function()
    -- redirect stdout and stderr to /dev/null to prevent any output
    local is_node_installed = os.execute("command -v node >/dev/null 2>&1")
    return is_node_installed == 0
end

return {
    {
        "zbirenbaum/copilot.lua",
        name = "copilot",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            -- requires node - exit if we don't have it
            if not check_node_installed() then
                return
            end
            Copilot = require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 25,
                    keymap = {
                        accept = "<C-y>",
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
