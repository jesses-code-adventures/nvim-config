local ud_path = vim.fn.expand("~/coding/personal/undefined.nvim")

return {
  "undefined",
  dir = ud_path,
  dev = true,
  enabled = false,
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
}
