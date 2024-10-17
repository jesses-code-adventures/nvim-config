return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = false },
    { 'tpope/vim-dotenv', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    -- {"n", "<leader>", function () vim.cmd("DBUI") end, "launch vim dadbod ui"},
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = vim.fn.expand("~/coding/rapid/papi/*"),
      callback = function()
        vim.g.db_ui_save_location = vim.fn.expand('~/coding/rapid/papi/model/queries')
      end
    })
  end,
}
