-- if using uv: `uv tool install ruff@latest`
-- osx: `brew install ruff`

---@type vim.lsp.Config
return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { ".ruff.toml", ".pyproject.toml", ".git" },
}

