-- GLOBAL COMMANDS
-- treat any file with .env in the name as a .env file for syntax highlighting
vim.cmd([[
  au BufNewFile,BufRead *.env.* set filetype=sh
]])

-- when yanking, highlight the yanked text
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

