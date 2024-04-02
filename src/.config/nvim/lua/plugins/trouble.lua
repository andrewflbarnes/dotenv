return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      "<leader>xx",
    },
    opts = {
      mode = 'document_diagnostics'
    },
    config = function()
      vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Trouble" })
    end
  },
}
