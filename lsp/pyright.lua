-- install with: npm i -g pyright

---@type vim.lsp.Config
return {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { "pyright-langserver", "--stdio", "--verbose" },
    filetypes = { "python" },
    root_markers = { ".pyproject.toml", ".git" },
    settings = {
        python = {}
    }
}

