-- Install with: npm i -g vscode-langservers-extracted

---@type vim.lsp.Config
return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    filetypes = { 'json', 'jsonc' },
    settings = {
        json = {
            validate = { enable = true },
            schemas = require('schemastore').json.schemas(),
        },
    },
}
