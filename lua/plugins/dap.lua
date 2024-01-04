return ({
    {
        'mfussenegger/nvim-dap',
        keys = {
            { "<F5>",        function() Dap.continue() end,                                                    desc = "debugger continue" },
            { "<F7>",        function() Dap.step_out() end,                                                    desc = "debugger step out" },
            { "<F8>",        function() Dap.step_into() end,                                                   desc = "debugger step into" },
            { "<F9>",        function() Dap.step_over() end,                                                   desc = "debugger step over" },
            { "<leader>dc",  function() Dap.disconnect() end,                                                  desc = "debugger disconnect" },
            { "<leader>b",   function() Dap.toggle_breakpoint() end,                                           desc = "debugger toggle breakpoint" },
            { "<leader>B",   function() Dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,        desc = "debugger conditional breakpoint" },
            { "<leader>lp",  function() Dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "debugger set log breakpoint" },
            { "<leader>dr",  function() Dap.repl.open() end,                                                   desc = "debugger open repl" },
            { "<leader>dui", function() require("dapui").toggle() end,                                         desc = "toggle dap ui" },
        },
        config = function()
            Dap = require("dap")
            local file_type = vim.bo.filetype
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
            require("nvim-dap-virtual-text")
            Dap.listeners.after.event_initialized["dapui_config"] = function()
                require("dapui").open()
            end

            Dap.listeners.after.event_terminated["dapui_config"] = function()
                require("dapui").close()
            end

            Dap.listeners.after.event_exited["dapui_config"] = function()
                require("dapui").close()
            end
            -- Define handlers for each language
            local go_handling = function()
                require("dap-go").setup({
                    dap_configurations = {
                        {
                            -- Must be "go" or it will be ignored by the plugin
                            type = "go",
                            name = "Attach remote",
                            mode = "remote",
                            request = "attach",
                        },
                    },
                    -- delve configurations
                    delve = {
                        -- the path to the executable dlv which will be used for debugging.
                        -- by default, this is the "dlv" executable on your PATH.
                        path = "dlv",
                        -- time to wait for delve to initialize the debug session.
                        -- default to 20 seconds
                        initialize_timeout_sec = 20,
                        -- a string that defines the port to start delve debugger.
                        -- default to string "${port}" which instructs nvim-dap
                        -- to start the process in a random available port
                        port = "${port}",
                        -- additional args to pass to dlv
                        args = {},
                        -- the build flags that are passed to delve.
                        -- defaults to empty string, but can be used to provide flags
                        -- such as "-tags=unit" to make sure the test suite is
                        -- compiled during debugging, for example.
                        -- passing build flags using args is ineffective, as those are
                        -- ignored by delve in dap mode.
                        build_flags = "",
                    }
                })
            end

            local get_python_path = function()
                local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
                if venv_path then
                    return venv_path .. '/bin/python'
                end
                return nil
            end
            local python_handling = function()
                require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
                Dap.adapters.python = {
                    type = 'executable',
                    command = get_python_path(),
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        initialize_timeout_sec = 10,
                        disconnect_timeout_sec = 1,
                    }
                }

                Dap.configurations.python = {
                    {
                        type = 'python',
                        cwd = vim.fn.getcwd(),
                        request = 'launch',
                        name = "Launch file",
                        program = "${file}",
                        pythonPath = get_python_path(),
                    },
                }
            end
            if file_type == "python" then
                python_handling()
            elseif file_type == "go" then
                go_handling()
            end
        end,
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            { ft = "python", "mfussenegger/nvim-dap-python" },
            { ft = "go",     "leoluz/nvim-dap-go" },
            {
                "rcarriga/nvim-dap-ui",
                config = function()
                    require("dapui").setup({
                        icons = { expanded = "➕", collapsed = "➖", current_frame = "⚪️" },
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
                                -- Sidebar
                                -- i deleted the code for the bottom tray but it's in the dap ui github if you ever need it
                                elements = {
                                    -- Provide IDs as strings or tables with "id" and "size" keys
                                    { id = "watches",     size = 0.1 },
                                    { id = "breakpoints", size = 0.1 },
                                    { id = "repl",        size = 0.1 },
                                    {
                                        id = "scopes",
                                        size = 0.7
                                    },
                                },
                                size = 70,
                                position = "right", -- Can be "left" or "right"
                            },
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
                                play = "▶️",
                                step_into = "⏬",
                                step_over = "⏩",
                                step_out = "⏫",
                                step_back = "⏪",
                                run_last = "⏮",
                                terminate = "🥊",
                                disconnect = "🥀",
                            },
                        },
                        render = {
                            max_type_length = nil, -- Can be integer or nil.
                            max_value_lines = 100, -- Can be integer or nil.
                            indent = 1,
                        },
                    }
                    )
                end
            }
        }
    }
})
