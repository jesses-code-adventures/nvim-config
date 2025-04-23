-- Install with: npm install -g dockerfile-language-server-nodejs

---@type vim.lsp.Config
return {
    cmd = { 'docker-langserver', '--stdio' },
    filetypes = { 'dockerfile' },
}
