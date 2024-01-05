return {
    "tpope/vim-fugitive",
    keys={
        {"<leader>gs", "<cmd>Git<cr>", desc="open git in fugitive"},
        {"ga", "<cmd>diffget //2<CR>", ft=".git"},
        {"gl", "<cmd>diffget //3<CR>", ft=".git"},
        {"<leader>Gd", "<cmd>Gdiff<CR>", desc="Git diff", ft="fugitive"},
        {"<leader>Gp", "<cmd>Git pull<cr>", desc="Git pull", ft="fugitive"},
        {"<leader>GP", "<cmd>Git push<cr>", desc="Git push", ft="fugitive"},
        {"<leader>GO", "<cmd>Git push -u origin", desc="Git push to origin", ft="fugitive"},
    },
}
