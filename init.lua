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

require("settings")
require("keymaps")
require("commands")
require("autocmds")
require("lsp")

require("lazy").setup("plugins", {
    change_detection = { notify = false },
    rocks = { enable = false },
    performance = {
    rtp = {
        disabled_plugins = {
            'gzip',
            'netrwPlugin',
            'rplugin',
            'tarPlugin',
            'tohtml',
            'tutor',
            'zipPlugin',
        },
    },
    },
})

vim.keymap.set("n", "<leader>lz", "<cmd>:Lazy<cr>")

function R(name)
    require("plenary.reload").reload_module(name)
end
