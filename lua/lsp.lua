local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
    vim.keymap.set('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>dq', '<cmd>lua vim.diagnostic.setqflist()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>]d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
end

lspconfig.tsserver.setup({
    on_attach = global_on_attach,
    capabilities = capabilities
})

lspconfig.eslint.setup({
    on_attach = global_on_attach,
    capabilities = capabilities
})

lspconfig.gopls.setup({
    on_attach = global_on_attach,
    capabilities = capabilities
})

--- @param client table
--- @param bufnr number
local rust_on_attach = function(client, bufnr)
    global_on_attach(client, bufnr)
    if vim.fn.getcwd() == "/Users/jessewilliams/Coding/stm-test-rs" or vim.fn.getcwd() == "/Users/jessewilliams/Coding/stm-experiment-2" then
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

lspconfig.rust_analyzer.setup({
    on_attach = rust_on_attach,
    capabilities = capabilities
})

lspconfig.zls.setup({
    on_attach = rust_on_attach,
    capabilities = capabilities
})

lspconfig.marksman.setup({
    on_attach = global_on_attach,
    capabilities = capabilities,
    filetypes = { "markdown", "md" }
})

-- Assuming `capabilities` is defined somewhere in your config
local clangd_capabilities = vim.tbl_deep_extend('force', capabilities, {
    offsetEncoding = { 'utf-16' }
})

lspconfig.clangd.setup({
    on_attach = global_on_attach,
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = require 'lspconfig'.util.root_pattern(".clangd", ".git", "compile_commands.json", "compile_flags.txt"),
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

lspconfig.yamlls.setup({
    on_attach = global_on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
            },
            schemaDownload = true,
        }
    },
})

lspconfig.lua_ls.setup({
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

--- @param client table
--- @param bufnr number
local pyright_on_attach = function(client, bufnr)
    global_on_attach(client, bufnr)
    client.server_capabilities.hoverProvider = true
    client.server_capabilities.formattingProvider = false
end


lspconfig.pyright.setup({
    on_attach = pyright_on_attach,
    capabilities = capabilities,
    settings = {
        pyright = {
            disableOrganiseImports = true
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

--- @param client table
--- @param bufnr number
local ruff_on_attach = function(client, bufnr)
    global_on_attach(client, bufnr)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.formattingProvider = true
end

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
lspconfig.ruff_lsp.setup {
    on_attach = ruff_on_attach,
    capabilities = capabilities,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

--- @param client table
--- @param bufnr number
local tailwind_on_attach = function(client, bufnr)
    global_on_attach(client, bufnr)
end

lspconfig.tailwindcss.setup({
    on_attach = tailwind_on_attach,
    capabilities = capabilities,
    filetypes = { "html", "css", "scss", "javascript", "typescript", "svelte", "vue", "templ", "gohtml", "react", "astro" },
    init_options = { userLanguages = { templ = "html" } },
})

lspconfig.templ.setup({
    on_attach = global_on_attach,
    capabilities = capabilities
})

lspconfig.svelte.setup({
    on_attach = global_on_attach,
    capabilities = capabilities
})

lspconfig.html.setup({
    on_attach = global_on_attach,
    capabilities = capabilities,
    filetypes = { "html" },
})

lspconfig.htmx.setup({
    on_attach = global_on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

lspconfig.taplo.setup({
    on_attach = global_on_attach,
    capabilities = capabilities,
    filetypes = { "toml" },
})


lspconfig.prismals.setup({
    on_attach = global_on_attach,
    capabilities = capabilities,
    filetypes = { "prisma" },
})
