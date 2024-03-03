return ({
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
        },
        {
            'JoosepAlviste/nvim-ts-context-commentstring'
        },
        {
            "vrischmann/tree-sitter-templ",
            name = "treesitter-templ",
            ft = { "go", "templ" },
            lazy = false,
        },
    },
    keys = {
        { "<leader>tsc", "<cmd>TSContextToggle<cr>", desc = "toggle treesitter context" },
    },
    lazy=false,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "python", "rust", "typescript", "javascript", "prisma", "go", "lua", "sql", "ssh_config", "svelte", "tsx", "yaml", "toml", "vimdoc", "c" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true
            },
            additional_vim_regex_highlighting = false
        })
    end,
    build = ":TSUpdate"
})
