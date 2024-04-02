return {
  "voldikss/vim-floaterm",
  keys = {
    { "<leader>t" }
  },
  config = function()
    vim.keymap.set("n", "<leader>t", ":FloatermToggle myfloat<CR>", { desc = "open [t]erminal" })
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.7
    vim.g.floaterm_autoclose = 2
  end
}
