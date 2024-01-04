--- DAP
local dap = require("dap")

require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
require("nvim-dap-virtual-text")
require("mason-nvim-dap").setup({ ensure_installed = { "python", "node2" } })

--- Keymaps
vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<F7>", function() dap.step_out() end)
vim.keymap.set("n", "<F8>", function() dap.step_into() end)
vim.keymap.set("n", "<F9>", function() dap.step_over() end)
vim.keymap.set("n", "<leader>dc", function() dap.disconnect() end)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end)

local get_python_path = function()
    local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
    if venv_path then
        return venv_path .. '/bin/python'
    end
    return nil
end

dap.adapters.python = {
    type = 'executable',
    command = get_python_path(),
    args = { '-m', 'debugpy.adapter' },
    options = {
        initialize_timeout_sec = 10,
        disconnect_timeout_sec = 1,
    }
}

dap.configurations.python = {
    {
        type = 'python',
        cwd = vim.fn.getcwd(),
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = get_python_path(),
    },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
    require("dapui").close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
    require("dapui").close()
end


--- DAP UI
vim.keymap.set("n", "<leader>dui", function() require("dapui").toggle() end)
require("dapui").setup({
    icons = { expanded = "📤", collapsed = "🍃", current_frame = "🖼" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    element_mappings = {},
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    force_buffers = true,
    layouts = {
        {
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide IDs as strings or tables with "id" and "size" keys
                { id = "watches",     size = 0.1 },
                { id = "breakpoints", size = 0.1 },
                {
                    id = "scopes",
                    size = 0.8
                },
            },
            size = 80,
            position = "left", -- Can be "left" or "right"
        },
        -- {
        --   elements = {
        --     "repl",
        --     "console",
        --   },
        --   size = 10,
        --   position = "bottom", -- Can be "bottom" or "top"
        -- },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            ["close"] = { "q", "<Esc>" },
        },
    },
    controls = {
        enabled = vim.fn.exists("+winbar") == 1,
        element = "repl",
        icons = {
            pause = "⏸",
            play = "▶️a",
            step_into = "🪜",
            step_over = "⏩",
            step_out = "🪂",
            step_back = "⏪",
            run_last = "⏮",
            terminate = "💀",
            disconnect = "❌",
        },
    },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
        indent = 1,
    },
})
