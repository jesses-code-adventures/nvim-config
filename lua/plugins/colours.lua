local ud_path = vim.fn.expand("~/coding/personal/undefined.nvim")

return ({
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = false,
    enabled = false,
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
    enabled = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "soft",
        transparent_background_level = 1,
        ui_contrast = "high",
      })
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    lazy = false,
    enabled = true,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme flexoki-dark')
    end
  },
  {
    "undefined",
    dir = ud_path,
    dev = true,
    config = function()
      ---@diagnostic disable-next-line: undefined-field
      if not vim.loop.fs_stat(ud_path) then
        error("undefined.nvim not found...")
        return
      end
      vim.opt.runtimepath:append(vim.fn.expand(ud_path))
      require("undefined").set_colorscheme()
    end,
    lazy = false,
    enabled = false,
  }
})
