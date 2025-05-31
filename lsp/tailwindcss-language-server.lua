-- Install with: npm i -g @tailwindcss/language-server

---@type vim.lsp.Config
return {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less', 'postcss', 'html', 'vue', 'svelte', 'astro', 'markdown', 'javascriptreact', 'typescriptreact', 'templ' },
    root_markers = { 'package.json', 'tsconfig.json', 'go.mod', 'tailwind.config.js' },
    settings = {
        includeLanguages = {
            templ = "html",
        },
    },
}
