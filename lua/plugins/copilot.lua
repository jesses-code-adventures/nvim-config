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
        keys = {
            {"<C-Space>", mode={"i"}, function() require('copilot.suggestion').accept_line() end, desc="copilot accept suggestion"},
            {"<C-d>", mode={"i"}, function() require('copilot.suggestion').dismiss() end, desc="copilot dismiss suggestion"},
        },
        config = function()
            -- requires node - exit if we don't have it
            if not check_node_installed() then
                return
            end
            Copilot = require("copilot").setup({
                suggestion={enabled=false, auto_trigger=true}
            })
        end,

    }
}
