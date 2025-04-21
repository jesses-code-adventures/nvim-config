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
vim.keymap.set("n", "<leader>gt", [[:vsplit<CR><C-w>L:vertical resize -60<CR>:terminal<CR>]], { desc = "Open terminal in split pane" })
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })
vim.keymap.set('n', '<leader>cl', '<cmd>checkhealth lsp<cr>', { desc = "Check LSP health" })
