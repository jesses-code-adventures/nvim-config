return {
  {
    "supermaven-inc/supermaven-nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-Space>",
          clear_suggestion = "<C-x>",
          -- accept_word = "<C-Enter>",
        },
      })
    end,
  },
}
