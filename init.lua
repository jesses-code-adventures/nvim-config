require("set")
require("remap")

local function split_first(s, delimiter)
    local delimiter_pos = string.find(s, delimiter, 1, true)
    if not delimiter_pos then
        return s
    end
    local key = string.sub(s, 1, delimiter_pos - 1)
    local value = string.sub(s, delimiter_pos + 1)
    return key, value
end

local env_file = vim.fn.stdpath("config") .. "/.env"
local file = io.open(env_file, "r")
if file then
    for line in file:lines() do
        local key, value = split_first(line, "=")
        if key and value then
            vim.fn.setenv(key, value)
        end
    end
    file:close()
end

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
require("lsp")

vim.keymap.set("n", "<leader>lz", "<cmd>:Lazy<cr>")

function R(name)
    require("plenary.reload").reload_module(name)
end
