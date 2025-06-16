-- Install with: brew upgrade lua-language-server || brew install lua-language-server

---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            runtime = { version = "Lua 5.1" },
            diagnostics = {
                globals = { "bit", "vim", "it", "describe", "before_each", "after_each", "os", "require" },
            },
            library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.expand("lua/lsp.lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/blink.cmp/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/diffview.nvim/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/fzf-lua/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/lazy.nvim/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/nvim-dap-go/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/nvim-dap-ui/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/nvim-dap/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/nvim-treesitter/lua"),
                vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/plenary.nvim/lua"),
            }
        }
    },
}

