return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  depencences = "nvim-telescope/telescope.nvim",
  enabled = false,
  config = function()
    require("telescope").load_extension("rest")
    vim.keymap.set("n", "<leader>rs", ":lua Rest run <CR>")
    vim.keymap.set("n", "<leader>re", ":Telescope rest select_env<CR>")
  end
  -- keys={
  --   {"<leader>rs", ":Rest run <CR>" , mode="n", desc="REST run request."},
  --   {"<leader>re", ":Telescope rest select_env<CR>", mode="n", desc="REST select .env file."}
  -- }
}
