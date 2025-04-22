-- install with `sudo npm i -g pyright`

---@type vim.lsp.Config
return {
    capabilities = (function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.definition = {
            dynamicRegistration = true,
            linkSupport = true,
        }
        return capabilities
    end)(),
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { ".pyproject.toml", ".git" },
}

