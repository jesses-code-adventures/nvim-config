--- DAP
local dap = require("dap")
require("dapui").setup()
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
require("nvim-dap-virtual-text")
require("mason-nvim-dap").setup({ensure_installed = { "python", "node2"  }})

local get_python_path = function()
local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
 if venv_path then
   return venv_path .. '/bin/python'
 end
return nil
end

dap.adapters.python = {
  type = 'executable';
  command = get_python_path();
  args = { '-m', 'debugpy.adapter' };
  options = {
    initialize_timeout_sec = 10;
    disconnect_timeout_sec =  1;
  }
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = get_python_path();
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  require("dapui").open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
  require("dapui").close()
end

--- Standard mappings
vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<F7>", function () dap.step_out() end)
vim.keymap.set("n", "<F8>", function () dap.step_into() end)
vim.keymap.set("n", "<F9>", function () dap.step_over() end)
vim.keymap.set("n", "<leader>b", function () dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>B", function () dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set("n", "<leader>lp", function () dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set("n", "<leader>dr", function () dap.repl.open() end)


--- DAP UI
vim.keymap.set("n", "<leader>dui", function () require("dapui").toggle() end)
