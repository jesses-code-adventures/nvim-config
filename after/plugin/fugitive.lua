vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local JesseFugitive = vim.api.nvim_create_augroup("JesseFugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = JesseFugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}

        --git push (big P, dominant)
        vim.keymap.set("n", "<leader>GP", function()
            vim.cmd.Git('push')
        end, opts)

        -- git pull (little p, submissive)
        vim.keymap.set("n", "<leader>Gp", function()
            vim.cmd.Git({'pull'})
        end, opts)

        -- Gdiff for merge conflicts
        vim.keymap.set("n", "<leader>Gd", ":Gdiff<CR>", opts)

        -- push to upstream origin when first going remote
        -- GO (Git Origin)
        vim.keymap.set("n", "<leader>GO", ":Git push -u origin ", opts);

    end,
})
vim.keymap.set("n", "ga", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
