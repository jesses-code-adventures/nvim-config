local function getOsName()
    local osname
    if jit then
        return jit.os
    end

    local fh, _ = assert(io.popen("uname -o 2>/dev/null", "r"))
    if fh then
        osname = fh:read()
    end

    return osname or "Windows"
end

return ({
    { "nvim-treesitter/nvim-treesitter",
        name = "nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            if getOsName() == "Windows" then
                require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
                require 'nvim-treesitter.install'.prefer_git = false
            end
            require("nvim-treesitter.configs").setup({
                -- comment out ensure install improves startup time noticably
                -- ensure_installed = { "python", "rust", "typescript", "javascript", "prisma",  "lua", "sql", "ssh_config", "svelte", "tsx", "yaml", "toml", "vimdoc", "c", "markdown", "markdown_inline", "go"},
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true
                },
                additional_vim_regex_highlighting = false
            })
        end,
        build = ":TSUpdate"
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter-context",
    --     event = { "BufReadPost", "BufNewFile" },
    --     keys = {
    --         { "<leader>tsc", "<cmd>TSContextToggle<cr>", desc = "toggle treesitter context" },
    --     },
    -- },
    {
        "vrischmann/tree-sitter-templ",
        name = "treesitter-templ",
        ft = { "go", "templ" },
        event = { "BufReadPost", "BufNewFile" },
    },
})
