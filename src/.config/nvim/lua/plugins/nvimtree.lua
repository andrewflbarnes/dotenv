return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("nvim-tree").setup {
        view = {
          width = 45
        },
        renderer = {
          symlink_destination = false
        }
      }
      vim.keymap.set('n', '<leader>T', ':NvimTreeToggle<CR>', { desc = "[T]oggle NvimTree"})
      vim.keymap.set('n', '<F49>1', ':NvimTreeFindFile<CR>', { desc = "Find file in NvimTree" })
      vim.keymap.set('n', '<M-F1>1', ':NvimTreeFindFile<CR>', { desc = "Find file in NvimTree" })
    end
  },
}
