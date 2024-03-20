return {
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require'kanagawa'.setup{}
    end
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require 'catppuccin' .setup {}
    end
  },
  {
    'savq/melange-nvim',
  }
}
