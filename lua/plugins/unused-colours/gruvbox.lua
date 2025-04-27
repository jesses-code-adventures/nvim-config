local enabled = false

return enabled and {
  'ellisonleao/gruvbox.nvim',
  name = 'gruvbox',
  lazy = false,
  enabled = false,
  priority = 1000,
  config = function()
    require('gruvbox').setup({
      contrast = 'hard',
      italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
      },
    })
    vim.cmd('colorscheme gruvbox')
  end
} or {}
