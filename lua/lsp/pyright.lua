-- install with `pip install pyright`

---@type vim.lsp.Config
return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { ".pyproject.toml", ".git" },
}

