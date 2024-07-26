return ({
    {
        "williamboman/mason.nvim",
        name = "mason",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        name = "mason-lspconfig",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "cssls",
                    "lua_ls",
                    "rust_analyzer",
                    "tsserver",
                    "html",
                    "jsonls",
                    "marksman",
                    "svelte",
                    "templ",
                    "tailwindcss",
                    "taplo",
                    "vimls",
                    "gopls",
                    "htmx",
                    "prismals",
                    "bashls",
                    "snyk_ls",
                    "pyright",
                    "ruff_lsp",
                    "sqlls",
                    "yamlls",
                    "zls"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            { 'j-hui/fidget.nvim', opts = {} },
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'petertriho/cmp-git',
            { 'prisma/vim-prisma', ft = 'prisma' },
            {
                'L3MON4D3/LuaSnip',

            },
            {
                'laytan/tailwind-sorter.nvim',
                dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
                build = 'cd formatter && npm i && npm run build',
                config = true
            },
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        lazy = true,
        config = function()
            vim.keymap.set("n", "<leader>tws", ":TailwindSort<CR>")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                    { name = 'buffer' },
                })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('fugitive', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                    { name = 'buffer' },
                })
            })


            -- Use buffer source for `/` and `?`
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':'
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
})
