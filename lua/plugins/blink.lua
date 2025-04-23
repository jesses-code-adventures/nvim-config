return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function(_, opts)
    require('blink.cmp').setup(opts)
    vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
  end,
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

    completion = {
      list = {
        -- Insert items while navigating the completion list.
        selection = { preselect = false, auto_insert = true },
        -- max_items = 10,
      },
      documentation = { auto_show = true },
      menu = {
        auto_show = true,
      },
    },

    cmdline = {
      enabled = true,
      -- use 'inherit' to inherit mappings from top level `keymap` config
      keymap = { preset = 'cmdline' },
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == '/' or type == '?' then return { 'buffer' } end
        -- Commands
        if type == ':' or type == '@' then return { 'cmdline' } end
        return {}
      end,
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = {},
        },
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = true,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = true,
          },
        },
        -- Whether to automatically show the window when new completion items are available
        menu = { auto_show = true },
        -- Displays a preview of the selected item on the current line
        ghost_text = { enabled = true }
      }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
