return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    keymap = {
      preset = 'default',
      ['<C-c>'] = { 'show', 'show_documentation', 'hide_documentation' },

      -- unmap c-Space so copilot can have it
      ['<C-space>'] = {},
    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
