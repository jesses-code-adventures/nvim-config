local testing = false

local local_dev_path = "~/.config/local-plugs/dingllm"

local_dev_path = vim.fn.expand(local_dev_path)

if testing and not vim.loop.fs_stat(local_dev_path) then
    print("dingllm.nvim not found...")
    return {}
end

return {
    {
        testing and "dingllm" or "yacineMTB/dingllm.nvim",
        dir = testing and local_dev_path or nil,
        dev = testing,
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            if testing then
                vim.opt.runtimepath:append(',~/.config/local-plugs/dingllm.nvim')
            end
            local system_prompt =
            'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks. Include a newline ("\n") at the beginning of any answer..'
            local helpful_prompt =
            'You are a helpful assistant. What I have sent are my notes so far. You are very curt, yet helpful.'
            local dingllm = require 'dingllm'

            local function openai_replace()
                dingllm.invoke_llm_and_stream_into_editor({
                    url = 'https://api.openai.com/v1/chat/completions',
                    model = 'gpt-4o',
                    api_key_name = 'OPENAI_API_KEY',
                    system_prompt = system_prompt,
                    replace = true,
                }, custom_make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
            end

            local function openai_help()
                dingllm.invoke_llm_and_stream_into_editor({
                    url = 'https://api.openai.com/v1/chat/completions',
                    model = 'gpt-4o',
                    api_key_name = 'OPENAI_API_KEY',
                    system_prompt = helpful_prompt,
                    replace = false,
                }, custom_make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
            end

            local function anthropic_help()
                dingllm.invoke_llm_and_stream_into_editor({
                    url = 'https://api.anthropic.com/v1/messages',
                    model = 'claude-3-5-sonnet-20241022',
                    api_key_name = 'ANTHROPIC_API_KEY',
                    system_prompt = helpful_prompt,
                    replace = false,
                }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
            end

            local function anthropic_replace()
                dingllm.invoke_llm_and_stream_into_editor({
                    url = 'https://api.anthropic.com/v1/messages',
                    model = 'claude-3-5-sonnet-20241022',
                    api_key_name = 'ANTHROPIC_API_KEY',
                    system_prompt = system_prompt,
                    replace = true,
                }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
            end


            -- when anthropic credits run out, just move back to openai credits or add more anthropic credits
            vim.keymap.set({ 'n', 'v' }, '<leader>lr', anthropic_replace, { desc = 'llm replace codeblock' })
            vim.keymap.set({ 'n', 'v' }, '<leader>lh', anthropic_help, { desc = 'llm helpful response' })
        end,
    }
}
