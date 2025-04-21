-- Install with: npm i -g typescript-language-server

-- TODO: look into [vtsls](https://github.com/yioneko/vtsls)
return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json" },
}
