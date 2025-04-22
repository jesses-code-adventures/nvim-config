return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {},
  keys = {
    { "<leader>pf",  function() require("fzf-lua").files() end,                mode = "n", desc = "fuzzy find on open buffers" },
    { "<leader>ds",  function() require("fzf-lua").lsp_document_symbols() end, mode = "n", desc = "fuzzy find on open buffers" },
    { "<leader>xx",  function() require("fzf-lua").diagnostics_workspace() end, mode = "n", desc = "fuzzy find workspace diagnostics" },
    { '<leader>lg',  function() require("fzf-lua").live_grep() end,            mode = "n", desc = "live grep" },
    { '<leader>ps',  function() require("fzf-lua").grep_string() end,          mode = "n", desc = "project grep search" },
    { '<leader>pb',  function() require("fzf-lua").buffers() end,              mode = "n", desc = "fuzzy find on open buffers" },
    { '<leader>fw',  function() require("fzf-lua").grep_string() end,          mode = "n" },
    { '<leader>vh',  function() require("fzf-lua").help_tags() end,            mode = "n", desc = "get help tags" },
    { '<leader>gf', function() require("fzf-lua").git_files() end,            mode = "n", desc = "git files fuzzy find" },
    { '<leader>km',  function() require("fzf-lua").keymaps() end,              mode = "n", desc = "keymaps" },
  }
}
