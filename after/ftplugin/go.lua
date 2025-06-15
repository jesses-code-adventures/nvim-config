local fzf = require("fzf-lua")
if fzf ~= nil then
  vim.keymap.set("n", "<leader>xx", function()
    require("fzf-lua").diagnostics_workspace({
      file_filter = function(filename)
        return not string.match(filename, "^" .. vim.env.HOME .. "/go")
      end
    })
  end, { desc = "fuzzy find workspace diagnostics (excluding ~/go)" })
end
