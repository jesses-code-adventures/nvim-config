local win_width = vim.api.nvim_win_get_width(0)
local margin = 4 -- adjust margin as needed
vim.bo.textwidth = win_width - margin
vim.wo.wrap = true
vim.wo.breakindent = true
vim.wo.linebreak = true
vim.bo.formatoptions = vim.bo.formatoptions .. "t"
