return ({
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        functions = {},
      },
      transparent = true,
      terminal_colors = true,
      hide_interactive_statusline = true,
      sidebars = { "qf", "vista_kind", "terminal" },
      on_colours = function(colours)
        colours.hint = colours.orange
        colours.error = "#ff0000"
      end
    },
    config = function()
      vim.cmd.colorscheme("solarized-osaka")
    end
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "soft",
        transparent_background_level = 1,
        ui_contrast = "high",
      })
      -- vim.cmd.colorscheme("everforest")
    end,
  }
})
