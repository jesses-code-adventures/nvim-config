vim.api.nvim_create_autocmd({"FileType", "LspAttach"}, {
  pattern = "sql",
  callback = function()
    vim.cmd("setlocal tabstop=4 shiftwidth=4 softtabstop=4")
  end,
})
