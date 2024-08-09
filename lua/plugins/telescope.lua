return ({
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    tag = "0.1.5",
    cmd = "Telescope",
    dependencies = {
        'folke/trouble.nvim',
        'nvim-lua/plenary.nvim',
        "https://github.com/nvim-tree/nvim-web-devicons"
    },
    lazy = false,
    keys = {
        { "<leader>pf", "<cmd>Telescope find_files<cr>",                                                               desc = "fuzzy find on file names" },
        { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>" },
        { '<leader>lg', "<cmd>Telescope live_grep<cr>",                                                                desc = "live grep" },
        { '<leader>ps', function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "project grep search" },
        { "<leader>pb", "<cmd>Telescope buffers<cr>",                                                                  desc = "fuzzy find on open buffers" },
        { '<leader>vh', "<cmd>Telescope help_tags<cr>",                                                                desc = "get help tags" },
        { '<C-p>',      "<cmd>Telescope git_files<cr>",                                                                desc = "git files fuzzy find" },
        { '<leader>km', "<cmd>Telescope keymaps<cr>",                                                                 desc = "keymaps" },
    },
    opts = {
        defaults = {
            mappings = {
                i = { ["<c-t"] = require("trouble").open_with_trouble },
                n = { ["<c-t"] = require("trouble").open_with_trouble },
            },
            file_ignore_patterns = { ".templ.go" }
        },
    }
})
