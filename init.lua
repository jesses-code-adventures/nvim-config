------------- set global options
local home = os.getenv("HOME")
if home == nil then
    home = vim.fn.stdpath("data")
end

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
vim.opt.undodir = home .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 10

vim.opt.colorcolumn = "0"

vim.opt.laststatus = 3

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


------------- set global keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open Ex mode" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without overwriting register" })
vim.keymap.set("i", "<C-e>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location and center" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location and center" })
vim.keymap.set("n", "<leader>cf", "<cmd>:let @+ = expand('%')<CR>", { desc = "Copy current file path" })
vim.keymap.set("n", "<leader>FR", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "file wide replace word under cursor with word"})
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR><cmd>e<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +10<cr>", {desc="easy resize split up"})
vim.keymap.set("n", "<C-Down>", "<cmd>resize -10<cr>", {desc="easy resize split up"})
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -10<cr>", {desc="easy resize split left"})
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +10<cr>", {desc="easy resize split up"})
vim.api.nvim_set_keymap('n', '<leader>gt', [[:vsplit<CR><C-w>L:vertical resize -60<CR>:terminal<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })

-- autocmds, custom functions that aren't plugins
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
-- TODO: get this working
local function git_compare_selection_with_main()
  local _, line1, col1, _ = unpack(vim.fn.getpos("'<"))
  local _, line2, col2, _ = unpack(vim.fn.getpos("'>"))
  local current_branch = vim.fn.system("git branch --show-current"):gsub("%s+", "")
  local current_selection = vim.fn.getline(line1, line2)
  current_selection[1] = string.sub(current_selection[1], col1)
  current_selection[#current_selection] = string.sub(current_selection[#current_selection], 1, col2)
  local main_selection = vim.fn.systemlist(
    string.format("git show main:%s | sed -n '%d,%dp'", vim.fn.expand("%:p"), line1, line2)
  )
  for i = 1, #current_selection do
    local current_line = current_selection[i] or ""
    local main_line = main_selection[i] or ""
    if current_line ~= main_line then
      print(string.format("diff at line %d:\n  current: %s\n  main: %s", line1 + i - 1, current_line, main_line))
    end
  end
end
vim.keymap.set("v", "<leader>1", git_compare_selection_with_main)
local function wrap_markdown_text()
  local filetype = vim.bo.filetype
  if filetype == "markdown" then
    local win_width = vim.api.nvim_win_get_width(0)
    local margin = 4  -- adjust margin as needed
    vim.bo.textwidth = win_width - margin
    vim.wo.wrap = true
    vim.wo.breakindent = true
    vim.wo.linebreak = true
    vim.bo.formatoptions = vim.bo.formatoptions .. "t"
  end
end
vim.api.nvim_create_autocmd({"FileType", "VimResized"}, {
  pattern = "markdown",
  callback = wrap_markdown_text,
})
-- treat any file with .env in the name as a .env file for syntax highlighting
vim.cmd([[
  au BufNewFile,BufRead *.env.* set filetype=sh
]])
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = { notify = false },
})

vim.keymap.set("n", "<leader>lz", "<cmd>:Lazy<cr>")

function R(name)
    require("plenary.reload").reload_module(name)
end
