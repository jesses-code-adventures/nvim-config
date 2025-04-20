local enabled = false

return enabled and {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  enabled = enabled,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "soft",
      transparent_background_level = 1,
      ui_contrast = "high",
    })
    vim.cmd.colorscheme("everforest")
  end,
} or {}
