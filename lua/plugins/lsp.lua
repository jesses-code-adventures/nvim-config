return ({
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neoconf.nvim',
            'saghen/blink.cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            { 'j-hui/fidget.nvim', opts = {},    lazy = true },
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            { 'hrsh7th/nvim-cmp',
                opts = function(_, opts)
                    opts.sources = opts.sources or {}
                    table.insert(opts.sources, {
                        name = "lazydev",
                        group_index = 0,
                    })
                end
            },
            'petertriho/cmp-git',
            { 'prisma/vim-prisma', ft = 'prisma' },
            {
                'L3MON4D3/LuaSnip',
            },
        },
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        config = function()
            require("neoconf").setup()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )
            local global_on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>',
                    { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>dq', '<cmd>lua vim.diagnostic.setqflist()<CR>',
                    { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>',
                    { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>]d', '<cmd>lua vim.diagnostic.goto_next()<CR>',
                    { noremap = true, silent = true })
            end

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities,
                            on_attach = global_on_attach,
                        }
                    end,
                    zls = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.zls.setup({
                            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                            settings = {
                                zls = {
                                    enable_inlay_hints = true,
                                    enable_snippets = true,
                                    warn_style = true,
                                },
                            },
                            on_attach = global_on_attach,
                        })
                        vim.g.zig_fmt_parse_errors = 0
                        vim.g.zig_fmt_autosave = 0
                    end,
                    sqls = function()
                        require('lspconfig').sqls.setup({
                            -- cmd = {"sqls", "-config", "sqls.yml"};
                            -- ft = { 'mysql', 'sql' },
                            settings = {
                                sqls = {
                                    connections = {
                                        {
                                            driver = 'mysql',
                                            dataSourceName =
                                            'mysql://local:asecurepassword42069!@tcp(localhost:3420)/gt_bi_db_test',
                                        },
                                    }
                                }
                            }
                        })
                    end,
                    ruff = function()
                        require('lspconfig').ruff.setup({
                            init_options = {
                                settings = {
                                    configurationPreference = "filesystemFirst",
                                    lint = {
                                        enable = true,
                                        preview = true,
                                    },
                                    codeAction = {
                                        enable = true,
                                        enable_snippets = true,
                                        enable_inlay_hints = true,
                                    }
                                }
                            },
                            on_attach = global_on_attach,
                        })
                    end,
                    basedpyright = function()
                        require('lspconfig').basedpyright.setup({
                            init_options = {
                                settings = {
                                }
                            },
                            on_attach = global_on_attach,
                        })
                    end,
                    ["volar"] = function()
                        require("lspconfig").volar.setup({
                            ft = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
                            init_options = {
                                vue = {
                                    hybridMode = false,
                                },
                                typescript = {
                                    tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
                                },
                            },
                        })
                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            },
                            on_attach = global_on_attach,
                        }
                    end,
                    ["clangd"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.clangd.setup({
                            on_attach = global_on_attach,
                            cmd = { "clangd" },
                            ft = { "c", "cpp", "objc", "objcpp" },
                            root_dir = require 'lspconfig'.util.root_pattern(".clangd", ".git", "compile_commands.json",
                                "compile_flags.txt"),
                            single_file_support = true,
                            settings = {
                                clangd = {
                                    compileFlags = {
                                        add = { "-F/Library/Frameworks", "-framework SDL2" }
                                    }
                                }
                            },
                            capabilities = capabilities
                        })
                    end
                }
            })
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
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
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm(cmp_select),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                }),
                sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                        { name = 'vim-dadbod-completion' },
                    },
                    { name = 'buffer' }
                )
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
            vim.diagnostic.config({
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end
    },
})
