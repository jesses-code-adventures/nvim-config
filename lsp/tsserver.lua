-- Install with: npm i -g typescript-language-server

-- TODO: look into [vtsls](https://github.com/yioneko/vtsls)
return {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json" },
}
