local dev = false
local path = vim.fn.expand("~/coding/pg_query.nvim")

if dev and not vim.loop.fs_stat(path) then
    print("pg_query not found")
    return {}
end

return {
    {
        "jesses-code-adventures/pg_query.nvim",
        dir = dev and path or nil,
        dev = dev,
        enabled = true,
        keys = {
            { "<leader>pe", function() require("pg_query").edit(); end, mode = "n", desc = "Edit default param values for the query under the cursor." },
            { "<leader>pr", function() require("pg_query").run(); end, mode = "n", desc = "Pipe the formatted query into the output_cmd." },
        },
        opts = {
            output_mode='dbui',
            missing_creds='default',
            db_cred_labels = {
                db_name="DB_NAME",
                db_host="DB_HOST",
                db_port="DB_PORT_LOCAL",
                db_password="DB_PASSWORD",
                db_user="DB_USER",
            },
            ui = {
                field_separator=' ✦ ',
                fields_align_right=false,
            }
        }
    }
}
