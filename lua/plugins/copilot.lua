local check_node_installed = function()
    local handle = io.popen("node -v")
    if handle == nil then
        return false
    end
    local result = handle:read("*a")
    handle:close()
    if result == '' then
        return false
    end
    return true
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
