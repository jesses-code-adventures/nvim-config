-- install with: go install golang.org/x/tools/gopls@latest

---@type vim.lsp.Config
return {
    cmd = { "gopls" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    filetypes = { "go", "gomod" },
    root_markers = { ".git", "go.mod" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        }
    },
}
