-- install with: curl -L https://github.com/supabase-community/postgres-language-server/releases/download/latest/postgrestools_aarch64-apple-darwin -o postgrestools && chmod +x postgrestools && mv postgrestools ~/.local/bin/postgrestools

---@type vim.lsp.Config
return {
    cmd = { "postgrestools", "lsp-proxy" },
    filetypes = { 'sql' },
    root_markers = { 'postgrestools.jsonc' },
}
