return {
    {
        name = "neoformat",
        "sbdchd/neoformat",
        lazy = false,
        config = function()
            -- Configure Prettier to use 4-space indents
            vim.g.neoformat_typescript_prettier = {
                exe = "prettier",
                args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--tab-width", "4"},
                stdin = 1
            }
            vim.g.neoformat_try_node_exe = 1
            vim.g.neoformat_enabled_typescript = { 'prettier' }
            vim.g.neoformat_enabled_javascript = { 'prettier' }
            vim.g.neoformat_enabled_javascriptreact = { 'prettier' }
            vim.g.neoformat_enabled_typescriptreact = { 'prettier' }
            vim.g.neoformat_enabled_json = { 'prettier' }
            vim.g.neoformat_enabled_yaml = { 'prettier' }
            -- vim.g.neoformat_enabled_markdown = { 'prettier' }
            vim.g.neoformat_enabled_html = { 'prettier' }
            vim.g.neoformat_enabled_css = { 'prettier' }
            vim.g.neoformat_enabled_scss = { 'prettier' }
            vim.g.neoformat_enabled_rust = { 'rustfmt' }
            vim.g.neoformat_enabled_python = { 'ruff' }
            vim.g.neoformat_enabled_lua = { 'lua-format' }
            vim.g.neoformat_enabled_go = { 'gofmt' }

            local augroup = vim.api.nvim_create_augroup
            local neoformat_augroup = augroup('Neoformat', {})
            local autocmd = vim.api.nvim_create_autocmd
            autocmd('BufWritePre', {
                group = neoformat_augroup,
                pattern = '*.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.html,*.json,*.yaml,*.rs,*.py,*.lua,*.templ,*.go',
                command = 'Neoformat',
            })
        end
    }
}
