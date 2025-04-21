local enabled = false

return enabled and {
  'williamboman/mason.nvim',
  enabled = enabled,
  keys = {
    { "<leader>ma", '<cmd>Mason<CR>' },
  },
} or {}
