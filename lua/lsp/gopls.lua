-- install with `go install golang.org/x/tools/gopls@latest`

---@type vim.lsp.Config
return {
    cmd = { "gopls" },
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
    }
}
