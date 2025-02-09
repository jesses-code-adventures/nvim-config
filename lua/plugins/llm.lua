local testing = false

local local_dev_path = "~/.config/local-plugs/dingllm"

local_dev_path = vim.fn.expand(local_dev_path)

if testing and not vim.loop.fs_stat(local_dev_path) then
    print("llm.nvim not found...")
    return {}
elseif testing then
    vim.opt.runtimepath:append(';' .. local_dev_path)
end

return {
    {
        (testing and "llm") or "jesses-code-adventures/llm.nvim",
        dir = testing and local_dev_path or nil,
        dev = testing,
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            excluded_providers = { }, -- options: openai, deepseek, google, anthropic, groq
            picker = 'telescope', -- pass nil, if you prefer a non-modifiable buffer to select your models from
            replace_prompt =
            'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks. Include a newline ("\n") at the beginning of any answer..',
            help_prompt =
            'You are a helpful assistant. What I have sent are my notes so far. You are very curt, yet helpful.'
        },
        keys = {
            { '<leader>lr', function() require('llm').replace() end, mode = "n", { desc = 'llm replace codeblock' } },
            { '<leader>lr', function() require('llm').replace() end, mode = "v", { desc = 'llm replace codeblock' } },
            { '<leader>lh', function() require('llm').help() end, mode = "n", { desc = 'llm helpful response' } },
            { '<leader>lh', function() require('llm').help() end, mode = "v", { desc = 'llm helpful response' } },
            { '<leader>lm', function() require('llm').models() end, { desc = 'llm model selector' } },
            { '<leader>lc', function() require('llm').chat() end, { desc = 'llm chat window' } },
        },
    }
}
