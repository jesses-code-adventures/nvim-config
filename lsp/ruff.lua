-- install with: curl -LsSf https://astral.sh/ruff/install.sh | sh

---@type vim.lsp.Config
return {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { ".pyproject.toml", ".git", ".ruff.toml" },
    settings = {
        python = {}
    }
}

