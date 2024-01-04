return ({
    "nvim-treesitter/nvim-treesitter",
    name="treesitter",
    lazy=false,
    dependencies={
        "nvim-treesitter/nvim-treesitter-context",
        {
            name="treesitter-templ",
            ft={"go", "templ"},
            lazy=true,
            "vrischmann/tree-sitter-templ",
        },
    },
    keys={
        {"<leader>tsc", "<cmd>TSContextToggle<cr>", desc="toggle treesitter context"},
    },
    config=function()
        require("nvim-treesitter.configs").setup({
            ensure_installed={"python", "rust", "typescript", "javascript", "prisma", "go", "lua", "sql", "ssh_config", "svelte", "tsx", "yaml", "toml", "vimdoc"},
            sync_install=false,
            auto_install=true,
            highlight = {
                enable = true
            },
            additional_vim_regex_highlighting = false
        })
    end,
    build=":TSUpdate"
})

