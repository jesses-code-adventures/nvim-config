return {
    {
        'laytan/tailwind-sorter.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        ft = { "templ", "html", "javascript", "tsx", "typescript", "svelte" },
        config = function()
            vim.keymap.set("n", "<leader>tws", ":TailwindSort<CR>")
        end
    }
}
