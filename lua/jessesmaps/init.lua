require("jessesmaps.set")
require("jessesmaps.remap")
require("jessesmaps.packer")
require('Comment').setup()


local augroup = vim.api.nvim_create_augroup
local JessesGroup = augroup('JessesMaps', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})


function R(name)
    require("plenary.reload").reload_module(name)
end

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


vim.g.neoformat_try_node_exe = 1
vim.g.neoformat_enabled_typescript = { 'prettier' }
vim.g.neoformat_enabled_javascript = { 'prettier' }
vim.g.neoformat_enabled_javascriptreact = { 'prettier' }
vim.g.neoformat_enabled_typescriptreact = { 'prettier' }
vim.g.neoformat_enabled_json = { 'prettier' }
vim.g.neoformat_enabled_yaml = { 'prettier' }
vim.g.neoformat_enabled_markdown = { 'prettier' }
vim.g.neoformat_enabled_html = { 'prettier' }
vim.g.neoformat_enabled_css = { 'prettier' }
vim.g.neoformat_enabled_scss = { 'prettier' }
vim.g.neoformat_enabled_rust = { 'rustfmt' }
vim.g.neoformat_enabled_python = { 'black' }

local neoformat_augroup = augroup('Neoformat', {})
autocmd('BufWritePre', {
    group = neoformat_augroup,
    pattern = '*.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.html,*.json,*.yaml,*.md,*.rs,*.py',
    command = 'Neoformat',
})

autocmd({"InsertLeave"}, {
    group = JessesGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
