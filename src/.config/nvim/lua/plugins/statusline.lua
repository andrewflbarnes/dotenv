return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'BufNewFile', 'BufReadPost', 'VeryLazy' },
    config = function()
      require('lualine').setup()
    end
  }
}
