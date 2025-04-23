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
            }
        }
    },
}

