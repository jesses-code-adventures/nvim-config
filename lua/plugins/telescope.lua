return ({
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    tag = "0.1.5",
    cmd = "Telescope",
    dependencies = {
        'folke/trouble.nvim',
        'nvim-lua/plenary.nvim',
        "https://github.com/nvim-tree/nvim-web-devicons",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    keys = {
        { "<leader>pf", "<cmd>Telescope find_files<cr>",                                                               desc = "fuzzy find on file names" },
        { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>" },
        { '<leader>lg', "<cmd>Telescope live_grep<cr>",                                                                desc = "live grep" },
        { '<leader>ps', function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "project grep search" },
        { "<leader>pb", "<cmd>Telescope buffers<cr>",                                                                  desc = "fuzzy find on open buffers" },
        { '<leader>vh', "<cmd>Telescope help_tags<cr>",                                                                desc = "get help tags" },
        { '<C-p>',      "<cmd>Telescope git_files<cr>",                                                                desc = "git files fuzzy find" },
        { '<leader>km', "<cmd>Telescope keymaps<cr>",                                                                  desc = "keymaps" },
    },


    config = function()
        local trouble = require("trouble")
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = { ["<c-t"] = trouble.open_with_trouble },
                    n = { ["<c-t"] = trouble.open_with_trouble },
                },
                file_ignore_patterns = { ".templ.go" }
            },
            extensions = {
                fzf = {
                    fuzzy = true,     -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                },
            },
        })
        require('telescope').load_extension("fzf")
    end,
})
