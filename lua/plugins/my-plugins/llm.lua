local testing = false

local local_dev_path = "~/coding/personal/llm.nvim"

local_dev_path = vim.fn.expand(local_dev_path)

if testing and not vim.loop.fs_stat(local_dev_path) then
    print("llm.nvim not found...")
    return {}
elseif testing then
    vim.opt.runtimepath:append(';' .. local_dev_path)
end

return {
    {
        (testing and "llm.nvim") or "jesses-code-adventures/llm.nvim",
        dir = testing and local_dev_path or nil,
        dev = testing,
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            excluded_providers = { }, -- options: openai, deepseek, google, anthropic, groq
            picker = 'fzf-lua', -- pass nil, if you prefer a non-modifiable buffer to select your models from
            replace_prompt =
            'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. If generating sql, always use lowercase where possible. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks.',
            help_prompt =
            'You are a helpful assistant. What I have sent are my notes so far. You are very curt, yet helpful. If generating sql, always use lowercase where possible.'
        },
        keys = {
            { '<leader>lr', function() require('llm').replace() end, mode = "n", { desc = 'llm replace codeblock' } },
            { '<leader>lr', function() require('llm').replace() end, mode = "v", { desc = 'llm replace codeblock' } },
            { '<leader>lh', function() require('llm').help() end, mode = "n", { desc = 'llm helpful response' } },
            { '<leader>lh', function() require('llm').help() end, mode = "v", { desc = 'llm helpful response' } },
            { '<leader>lm', function() require('llm').models() end, { desc = 'llm model selector' } },
            { '<leader>ls', function() require('llm').settings() end, { desc = 'llm display settings' } },
            { '<leader>lc', function() require('llm').chat() end, { desc = 'llm chat window' } },
        },
    }
}
