return {
  {
    "diepm/vim-rest-console",
    enabled = true,
    ft = "rest",
    config = function()
      vim.g.vrc_set_default_mapping = 0
      vim.g.vrc_response_default_content_type = "application/json"
      vim.g.vrc_output_buffer_name = "_OUTPUT.json"
      vim.g.vrc_auto_format_response_patterns = {
        json = "jq"
      }
      -- should be able to pass multiple env files and find the first match in the working dir recursively
      vim.api.nvim_set_keymap("n", "<leader>r", ":call VrcQuery()<CR>", {})
    end,
  }
}
