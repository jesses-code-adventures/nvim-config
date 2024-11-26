local dev = true
local path = vim.fn.expand("~/coding/pg_query.nvim")

if not vim.loop.fs_stat(path) then
    print("pg_query not found")
    return {}
end

return {
    {
        "jesses-code-adventures/pg_query.nvim",
        dir = dev and path or nil,
        dev = dev,
        enabled = true,
        lazy = false,
        keys = {
            { "<leader>pw", function() require("pg_query").write(); end, mode = "n", desc = "Edit default param values for the query under the cursor." },
            { "<leader>pr", function() require("pg_query").render(); end, mode = "n", desc = "Render postgres query with values, and pipe into output_cmd." },
        },
        opts = {
            field_separator=' ✦ ',
            fields_align_right=false,
            output_cmd='pbcopy',
        }
    }
}
