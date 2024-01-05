return {
    {
        name = "neoformat",
        "sbdchd/neoformat",
        lazy = false,
        config = function()
            local augroup = vim.api.nvim_create_augroup
            vim.g.neoformat_try_node_exe = 1
            vim.g.neoformat_enabled_typescript = { 'prettier' }
            vim.g.neoformat_enabled_javascript = { 'prettier' }
            vim.g.neoformat_enabled_javascriptreact = { 'prettier' }
            vim.g.neoformat_enabled_typescriptreact = { 'prettier' }
            vim.g.neoformat_enabled_json = { 'prettier' }
            vim.g.neoformat_enabled_yaml = { 'prettier' }
            vim.g.neoformat_enabled_markdown = { 'prettier' }
            vim.g.neoformat_enabled_html = { 'prettier' }
            vim.g.neoformat_enabled_css = { 'prettier' }
            vim.g.neoformat_enabled_scss = { 'prettier' }
            vim.g.neoformat_enabled_rust = { 'rustfmt' }
            vim.g.neoformat_enabled_python = { 'ruff' }
            vim.g.neoformat_enabled_lua = { 'lua-format' }

            local neoformat_augroup = augroup('Neoformat', {})
            local autocmd = vim.api.nvim_create_autocmd
            autocmd('BufWritePre', {
                group = neoformat_augroup,
                pattern = '*.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.html,*.json,*.yaml,*.md,*.rs,*.py,*.lua',
                command = 'Neoformat',
            })
        end
    }
}
