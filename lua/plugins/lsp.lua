local developing = false

return ({
    {
        "williamboman/mason.nvim",
        name = "mason",
        config = function()
            require("mason").setup()
        end,
        cmd = "Mason"
    },
    {
        "williamboman/mason-lspconfig.nvim",
        name = "mason-lspconfig",
        dependencies = { "mason" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("mason-lspconfig").setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        dependencies = {
            'folke/neoconf.nvim',
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
                        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
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
            local lsp = require('lspconfig')
            local cmp = require("cmp")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
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
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' }
                }
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

            cmp.setup({
              -- completion for dadbod
              sources = {
                { name = 'vim-dadbod-completion' }
              }
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
                virtual_text = { source = "always", severity_sort = "true" }
            })

            vim.filetype.add({
                extension = {
                    templ = "templ"
                }
            })

            --- @param bufnr integer
            local global_on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
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

            --- @param client table
            --- @param bufnr number
            local rust_on_attach = function(client, bufnr)
                global_on_attach(client, bufnr)
                if vim.fn.getcwd() == vim.fn.expand("~/Coding/stm-test-rs") or vim.fn.getcwd() == vim.fn.expand("~/Coding/stm-experiment-2") then
                    print("setting the target in rust analyzer")
                    client.config.settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                target = "thumbv7em-none-eabihf",
                            },
                            check = {
                                allTargets = false,
                            },
                        },
                    }
                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
            end

            --- @param client table
            --- @param bufnr number
            local pyright_on_attach = function(client, bufnr)
                global_on_attach(client, bufnr)
                client.server_capabilities.hoverProvider = true
                client.server_capabilities.formattingProvider = false
            end

            --- @param client table
            --- @param bufnr number
            local ruff_on_attach = function(client, bufnr)
                global_on_attach(client, bufnr)
                client.server_capabilities.hoverProvider = false
                client.server_capabilities.formattingProvider = true
            end

            --- @param client table
            --- @param bufnr number
            local tailwind_on_attach = function(client, bufnr)
                global_on_attach(client, bufnr)
            end

            -- Assuming `capabilities` is defined somewhere in your config
            local clangd_capabilities = vim.tbl_deep_extend('force', capabilities, {
                offsetEncoding = { 'utf-16' }
            })

            lsp.ts_ls.setup({
                on_attach = global_on_attach,
                capabilities = capabilities
            })

            lsp.eslint.setup({
                on_attach = global_on_attach,
                capabilities = capabilities
            })

            lsp.gopls.setup({
                on_attach = global_on_attach,
                capabilities = capabilities
            })

            lsp.rust_analyzer.setup({
                on_attach = rust_on_attach,
                capabilities = capabilities
            })

            lsp.zls.setup({
                on_attach = rust_on_attach,
                capabilities = capabilities
            })

            -- lsp.marksman.setup({
            --     on_attach = global_on_attach,
            --     capabilities = capabilities,
            --     filetypes = { "markdown", "md" }
            -- })

            lsp.clangd.setup({
                on_attach = global_on_attach,
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
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
                capabilities = clangd_capabilities
            })

            lsp.yamlls.setup({
                on_attach = global_on_attach,
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*openapispec.yaml"
                        },
                        schemaDownload = true,
                    }
                },
            })

            lsp.lua_ls.setup({
                on_attach = global_on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "it", "describe", "before_each", "after_each" },
                        }
                    }
                },
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                            Lua = {
                                runtime = { version = 'LuaJIT' },
                                workspace = {
                                    checkThirdParty = false,
                                    library = { vim.env.VIMRUNTIME }
                                }
                            }
                        })
                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end
            })

            lsp.pyright.setup({
                on_attach = pyright_on_attach,
                capabilities = capabilities,
                settings = {
                    pyright = {
                        disableOrganiseImports = false
                    },
                    python = {
                        analysis = {
                            ignore = { "*" }
                        },
                    },
                },
                init_options = {
                    settings = {
                        -- Any extra CLI arguments for `pyright` go here.
                        args = {},
                    }
                }
            })

            -- Configure `ruff-lsp`.
            -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
            -- For the default config, along with instructions on how to customize the settings
            lsp.ruff_lsp.setup {
                on_attach = ruff_on_attach,
                capabilities = capabilities,
                init_options = {
                    settings = {
                        -- Any extra CLI arguments for `ruff` go here.
                        args = {},
                    }
                }
            }

            lsp.tailwindcss.setup({
                on_attach = tailwind_on_attach,
                capabilities = capabilities,
                filetypes = { "html", "css", "scss", "javascript", "typescript", "svelte", "vue", "templ", "gohtml", "react", "astro" },
                init_options = { userLanguages = { templ = "html" } },
            })

            lsp.templ.setup({
                on_attach = global_on_attach,
                capabilities = capabilities
            })

            lsp.svelte.setup({
                on_attach = global_on_attach,
                capabilities = capabilities,
            })

            lsp.html.setup({
                on_attach = global_on_attach,
                capabilities = capabilities,
                filetypes = { "html" },
            })

            lsp.htmx.setup({
                on_attach = global_on_attach,
                capabilities = capabilities,
                filetypes = { "html", "templ" },
            })

            lsp.taplo.setup({
                on_attach = global_on_attach,
                capabilities = capabilities,
                filetypes = { "toml" },
            })


            lsp.prismals.setup({
                on_attach = global_on_attach,
                capabilities = capabilities,
                filetypes = { "prisma" },
            })

            if developing then
                vim.api.nvim_create_autocmd('FileType', {
                    pattern = "python",
                    callback = function()
                        vim.lsp.start({
                            name = "pygo_lsp",
                            cmd = { "pygo_lsp" },
                        })
                    end
                })
            end
        end
    },
})
