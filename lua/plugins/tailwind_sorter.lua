return {
    {
        'laytan/tailwind-sorter.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        filetypes = { "templ", "html", "javascript", "tsx", "typescript", "svelte" },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.keymap.set("n", "<leader>tws", ":TailwindSort<CR>")
        end
    }
}
