-- install with: curl -L https://github.com/supabase-community/postgres-language-server/releases/download/0.6.0/postgrestools_aarch64-apple-darwin -o ~/.local/bin/postgrestools && chmod +x ~/.local/bin/postgrestools

---@type vim.lsp.Config
return {
    cmd = { "postgrestools", "lsp-proxy" },
    filetypes = { 'sql', 'psql' },
    root_markers = { 'postgrestools.jsonc' },
    single_file_support = true,
}
