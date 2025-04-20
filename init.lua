local home = os.getenv("HOME")
if home == nil then
    home = vim.fn.stdpath("data")
end

-- GLOBAL OPTIONS
vim.opt.mouse = "a"
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 10
vim.opt.colorcolumn = "0"
vim.opt.laststatus = 2
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- GLOBAL KEYMAPS
vim.g.mapleader = " "

local function nav()
    local has_oil, _ = pcall(require, 'oil')
    if has_oil then
        vim.cmd.Oil()
    else
        vim.cmd.Ex()
    end
end

vim.keymap.set("n", "-", nav, { desc = "Navigate directory" })
vim.keymap.set("n", "<leader>pv", nav, { desc = "Open Ex mode" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })
vim.keymap.set("x", "<leader>pp", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without overwriting register" })
vim.keymap.set("i", "<C-e>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set("n", "<leader>cf", "<cmd>:let @+ = expand('%')<CR>", { desc = "Copy current file path" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR><cmd>e<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +10<cr>", { desc = "easy resize split up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -10<cr>", { desc = "easy resize split up" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -10<cr>", { desc = "easy resize split left" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +10<cr>", { desc = "easy resize split up" })
vim.keymap.set("n", "<C-S>", "<cmd>source %<cr>", { desc = "source current file" })
vim.keymap.set("n", "<CR>", "", { desc = "disable enter" })
vim.api.nvim_set_keymap('n', '<leader>gt', [[:vsplit<CR><C-w>L:vertical resize -60<CR>:terminal<CR>]],
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })

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

-- DIAGNOSTICS
vim.diagnostic.config({
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    virtual_text = true,
})

-- LSP
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(e)
--         local client = vim.lsp.get_client_by_id(e.data.client_id)
--         if client == nil then
--             return
--         end
--         local opts = { buffer = e.buf, remap = false }
--         -- TODO: work out inbuilt diagnostic open float
--         vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--         if client:supports_method('textDocument/completion') then
--             vim.lsp.completion.enable(true, client.id, e.buf)
--         end
--     end
-- })
--
-- vim.lsp.config('*', {
--     capabilities = vim.lsp.protocol.make_client_capabilities(),
--     root_markers = { '.git' },
-- })
--
-- vim.lsp.config.lua_ls = {
--     cmd = { 'lua-language-server' },
--     filetypes = { 'lua' },
--     root_markers = { '.luarc.json', '.luarc.jsonc' },
--     settings = {
--         Lua = {
--             runtime = { version = "Lua 5.1" },
--             diagnostics = {
--                 globals = { "bit", "vim", "it", "describe", "before_each", "after_each", "os", "require" },
--             }
--         }
--     },
-- }
--
-- vim.lsp.config.tsserver = {
--     cmd = { "typescript-language-server", "--stdio" },
--     filetypes = { "typescript", "typescriptreact" }
-- }
--
-- vim.lsp.config.ruff = {
--     cmd = { "ruff", "server" },
--     filetypes = { "python" },
--     root_markers = { ".ruff.toml", ".pyproject.toml", ".git" },
-- }
--
-- vim.lsp.config.basedpyright = {
--     cmd = { "basedpyright" },
--     filetypes = { "python" },
-- }
--
-- vim.lsp.config.gopls = {
--     cmd = { "gopls" },
--     filetypes = { "go", "gomod" },
--     root_markers = { ".git", "go.mod" },
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--                 shadow = true,
--             },
--             staticcheck = true,
--         }
--     }
-- }
--
-- vim.lsp.enable({ "lua_ls", "tsserver", "ruff", "basedpyright", "gopls", "pyright" })

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazy_path,
    })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup("plugins", {
    change_detection = { notify = false },
})

vim.keymap.set("n", "<leader>lz", "<cmd>:Lazy<cr>")

function R(name)
    require("plenary.reload").reload_module(name)
end
