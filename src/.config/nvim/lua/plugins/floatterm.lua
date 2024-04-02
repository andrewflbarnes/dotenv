return {
  "voldikss/vim-floaterm",
  keys = {
    { "<leader>t", ":FloatermToggle myfloat<CR>", mode = "n", desc = "open [t]erminal" }
  },
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.7
    vim.g.floaterm_autoclose = 2
  end
}
