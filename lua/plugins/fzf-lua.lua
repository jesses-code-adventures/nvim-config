---@param ignore_patterns string[]
local function rg_command(ignore_patterns)
  local flags = ""
  for _, pattern in ipairs(ignore_patterns) do
    flags = flags .. "-g !'" .. pattern .. "' "
  end
end

local grep_ignore_patters = {
  "*_mocks.go",
  "*mocks_test.go",
  ".git",
  "**/*.sql.go",
  "**/*_templ.go",
  "**/*mocks.go",
  "**/*mocks_test.go",
  "_tmp",
}

local fd_ignore_patterns = {
  ".git",
  "**/*.sql.go",
  "**/*_templ.go",
  "**/*mocks.go",
  "**/*mocks_test.go",
  "_tmp",
}

local function live_grep_command()
  local msg = "rg -. -g '!*_mocks.go' -g '!*mocks_test.go' -g '!.git' -g '!**/*.sql.go' -g '!*_templ.go' -g '!_tmp'"
  return msg
end

local function files_command()
  local msg = "fd -t f -E '.git' -E '**/*.sql.go' -E '**/*_templ.go' -E '**/*mocks.go' -E '**/*mocks_test.go' -E '_tmp'"
  return msg
end

return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "<leader>pf", function() require("fzf-lua").files({ cmd = files_command() }) end, mode = "n",      desc = "fuzzy find files" },
    { "<leader>ds", function() require("fzf-lua").lsp_document_symbols() end,  mode = "n",      desc = "fuzzy find on open buffers" },
    { "<leader>xx", function() require("fzf-lua").diagnostics_workspace() end, mode = "n",      desc = "fuzzy find workspace diagnostics" },
    { "<leader>lg", function() require 'fzf-lua'.live_grep({ cmd = live_grep_command() }) end, desc = "live grep" },
    { '<leader>ps', function() require("fzf-lua").grep() end,           mode = "n",      desc = "project grep search" },
    { '<leader>pb', function() require("fzf-lua").buffers() end,               mode = "n",      desc = "fuzzy find on open buffers" },
    { '<leader>fw', function() require("fzf-lua").grep_string() end,           mode = "n" },
    { '<leader>vh', function() require("fzf-lua").help_tags() end,             mode = "n",      desc = "get help tags" },
    { '<leader>gf', function() require("fzf-lua").git_files() end,             mode = "n",      desc = "git files fuzzy find" },
    { '<leader>km', function() require("fzf-lua").keymaps() end,               mode = "n",      desc = "keymaps" },
  }
}
