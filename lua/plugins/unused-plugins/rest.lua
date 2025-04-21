local enabled = false

return enabled and {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  depencences = "nvim-telescope/telescope.nvim",
  enabled = enabled,
  config = function()
    -- require("telescope").load_extension("rest")
    vim.keymap.set("n", "<leader>rs", ":lua Rest run <CR>")
    -- vim.keymap.set("n", "<leader>re", ":Telescope rest select_env<CR>")
  end
} or {}
