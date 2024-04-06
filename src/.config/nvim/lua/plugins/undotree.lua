return {
  event = { "BufReadPost", "BufNewFile" },
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<S-U>", ":UndotreeToggle<CR>")
  end
}
