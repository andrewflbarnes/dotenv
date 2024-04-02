return {
  {
    "rose-pine/neovim",
    priority = 1000,
    name = "rose-pine",
    lazy = false,
    config = function()
      require("rose-pine").setup({})
      vim.cmd([[colorscheme rose-pine]])
    end
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup({})
    end
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require("catppuccin").setup({})
    end
  },
  {
    'savq/melange-nvim',
  }
}
