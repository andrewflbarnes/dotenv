return {
  {
    "lewis6991/gitsigns.nvim",
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { 'gsb', ':Gitsigns toggle_current_line_blame<CR>', mode = { 'n', 'v' }, desc = "[g]it[s]igns toggle [b]lame" },
      { 'gsn', ':Gitsigns next_hunk<CR>', mode = { 'n', 'v' }, desc = "[g]it[s]igns [n]ext hunk" },
      { 'gsp', ':Gitsigns preview_hunk<CR>', mode = { 'n', 'v' }, desc = "[g]it[s]igns [p]review hunk" },
      { 'gsr', ':Gitsigns reset_hunk<CR>', mode = { 'n', 'v' }, desc = "[g]it[s]igns [r]eset hunk" },
      { 'gst', function()
        local tog = not vim.g.gitsigns_toggled
        require('gitsigns').setup({
          linehl = tog,
          word_diff = tog,
          show_deleted = tog,
        })
        vim.g.gitsigns_toggled = tog
        vim.cmd('Gitsigns refresh')
      end,
      mode = { 'n', 'v' },
      desc = "[g]it[s]igns [t]oggle"
    },
    config = function()
      require('gitsigns').setup {
        signcolumn = false,
        numhl = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 1,
        },
      }

    end,
  },
},
}
