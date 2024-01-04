return ({
    "nvim-telescope/telescope.nvim",
    name="telescope",
    tag="0.1.5",
    cmd="Telescope",
    dependencies = {
		'nvim-lua/plenary.nvim',
        'folke/trouble.nvim'
	},
    lazy=false,
    keys={
        { "<leader>pf", "<cmd>Telescope find_files<cr>", desc="fuzzy find on file names" },
        { '<leader>ps', function() require("telescope.builtin").grep_string({search=vim.fn.input("Grep > ")}) end, desc="project grep search" },
        { '<leader>vh', "<cmd>Telescope help_tags<cr>", desc="get help tags"},
        { '<C-p>', "<cmd>Telescope git_files<cr>", desc="git files fuzzy find"},
    },
    opts={
        defaults = {
            mappings = {
                i = { ["<c-t"] = require("trouble").open_with_trouble },
                n = { ["<c-t"] = require("trouble").open_with_trouble },
            },
        },
    }
})
