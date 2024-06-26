local function getOsName()
  local osname
  if jit then
    return jit.os
  end

local fh, _ = assert(io.popen("uname -o 2>/dev/null", "r"))
  if fh then
    osname = fh:read()
  end

  return osname or "Windows"
end

return ({
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
        },
        {
            'JoosepAlviste/nvim-ts-context-commentstring'
        },
        {
            "vrischmann/tree-sitter-templ",
            name = "treesitter-templ",
            ft = { "go", "templ" },
            lazy = false,
        },
    },
    keys = {
        { "<leader>tsc", "<cmd>TSContextToggle<cr>", desc = "toggle treesitter context" },
    },
    lazy=false,
    config = function()
        if getOsName() == "Windows" then
            -- print("compiling using clang for windows")
            require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
            require 'nvim-treesitter.install'.prefer_git = false
        else
            -- print("compiling default behaviour outside windows")
        end
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "python", "rust", "typescript", "javascript", "prisma",  "lua", "sql", "ssh_config", "svelte", "tsx", "yaml", "toml", "vimdoc", "c", "markdown", "markdown_inline"},
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true
            },
            additional_vim_regex_highlighting = false
        })
    end,
    build = ":TSUpdate"
})
