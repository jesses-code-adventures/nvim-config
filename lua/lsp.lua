local methods = vim.lsp.protocol.Methods

--- Diagnostic severities.
local diagnostic_icons = {
    ERROR = '',
    WARN = '',
    HINT = '',
    INFO = '',
}

local M = {}

vim.g.inlay_hints = false

local function on_attach(client, bufnr)
    print(client.name)
    vim.keymap.set({ 'n', 'x' }, 'gra', '<cmd>FzfLua lsp_code_actions<cr>',
        { buffer = bufnr, desc = 'vim.lsp.buf.code_action()' })

    vim.keymap.set('n', 'grr', '<cmd>FzfLua lsp_references<cr>', { buffer = bufnr, desc = 'vim.lsp.buf.references()' })

    vim.keymap.set('n', 'gy', '<cmd>FzfLua lsp_typedefs<cr>', { buffer = bufnr, desc = 'Go to type definition' })
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end,
        { buffer = bufnr, desc = 'Show diagnostics' })

    vim.keymap.set('n', '<leader>fs', '<cmd>FzfLua lsp_document_symbols<cr>',
        { buffer = bufnr, desc = 'Document symbols' })
    vim.keymap.set('n', '<leader>fS', function()
        -- Disable the grep switch header.
        require('fzf-lua').lsp_live_workspace_symbols({ no_header_i = true })
    end, { buffer = bufnr, desc = 'Workspace symbols' })

    vim.keymap.set('n', '[d', function()
        vim.diagnostic.jump({ count = -1 })
    end, { buffer = bufnr, desc = 'Previous diagnostic' })
    vim.keymap.set('n', ']d', function()
        vim.diagnostic.jump({ count = 1 })
    end, { buffer = bufnr, desc = 'Next diagnostic' })
    vim.keymap.set('n', '[e', function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
    end, { buffer = bufnr, desc = 'Previous error' })
    vim.keymap.set('n', ']e', function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
    end, { buffer = bufnr, desc = 'Next error' })

    if client:supports_method(methods.textDocument_definition, bufnr) then
        vim.keymap.set('n', 'gd', function()
            require('fzf-lua').lsp_definitions({ jump1 = true })
        end, { buffer = bufnr, desc = 'Go to definition' })
        vim.keymap.set('n', 'gD', function()
            require('fzf-lua').lsp_definitions({ jump1 = false })
        end, { buffer = bufnr, desc = 'Peek definition' })
    else
        print(client.name)
        print('go to definition not supported')
    end

    if client:supports_method(methods.textDocument_signatureHelp) then
        local blink_window = require('blink.cmp.completion.windows.menu')
        local blink = require('blink.cmp')

        vim.keymap.set('i', '<C-k>', function()
            -- Close the completion menu first (if open).
            if blink_window.win:is_open() then
                blink.hide()
            end

            vim.lsp.buf.signature_help()
        end, { buffer = bufnr, desc = 'Signature help' })
    end

    if client:supports_method(methods.textDocument_documentHighlight) then
        local under_cursor_highlights_group =
            vim.api.nvim_create_augroup('mariasolos/cursor_highlights', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if client:supports_method(methods.textDocument_inlayHint) and vim.g.inlay_hints then
        local inlay_hints_group = vim.api.nvim_create_augroup('mariasolos/toggle_inlay_hints', { clear = false })

        -- Initial inlay hint display.
        -- Idk why but without the delay inlay hints aren't displayed at the very start.
        vim.defer_fn(function()
            local mode = vim.api.nvim_get_mode().mode
            vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = bufnr })
        end, 500)

        vim.api.nvim_create_autocmd('InsertEnter', {
            group = inlay_hints_group,
            desc = 'Enable inlay hints',
            buffer = bufnr,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                end
            end,
        })

        vim.api.nvim_create_autocmd('InsertLeave', {
            group = inlay_hints_group,
            desc = 'Disable inlay hints',
            buffer = bufnr,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end,
        })
    end

    -- Add "Fix all" command for ESLint.
    if client.name == 'eslint' then
        vim.keymap.set('n', '<leader>ce', function()
            if not client then
                return
            end

            client:request(vim.lsp.protocol.Methods.workspace_executeCommand, {
                command = 'eslint.applyAllFixes',
                arguments = {
                    {
                        uri = vim.uri_from_bufnr(bufnr),
                        version = vim.lsp.util.buf_versions[bufnr],
                    },
                },
            }, nil, bufnr)
        end, { desc = 'Fix all ESLint errors', buffer = bufnr })
    end
end

-- Define the diagnostic signs.
for severity, icon in pairs(diagnostic_icons) do
    local hl = 'DiagnosticSign' .. severity:sub(1, 1) .. severity:sub(2):lower()
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Diagnostic configuration.
vim.diagnostic.config {
    virtual_text = {
        prefix = '',
        spacing = 2,
        format = function(diagnostic)
            -- Use shorter, nicer names for some sources:
            local special_sources = {
                ['Lua Diagnostics.'] = 'lua',
                ['Lua Syntax Check.'] = 'lua',
            }
            local message = diagnostic_icons[vim.diagnostic.severity[diagnostic.severity]]
            if diagnostic.source then
                message = string.format('%s %s', message, special_sources[diagnostic.source] or diagnostic.source)
            end
            if diagnostic.code then
                message = string.format('%s[%s]', message, diagnostic.code)
            end

            return message .. ' '
        end,
    },
    float = {
        source = 'if_many',
        -- Show severity icons as prefixes.
        prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(' %s ', diagnostic_icons[level])
            return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
        end,
    },
    -- Disable signs in the gutter.
    signs = false,
}

-- Override the virtual text diagnostic handler so that the most severe diagnostic is shown first.
local show_handler = vim.diagnostic.handlers.virtual_text.show
assert(show_handler)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
    show = function(ns, bufnr, diagnostics, opts)
        table.sort(diagnostics, function(diag1, diag2)
            return diag1.severity > diag2.severity
        end)
        return show_handler(ns, bufnr, diagnostics, opts)
    end,
    hide = hide_handler,
}

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
    return hover {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
    }
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
    return signature_help {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
    }
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- I don't think this can happen but it's a wild world out there.
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        local server_configs = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            :totable()

        vim.lsp.enable(server_configs)
    end,
})

return M
