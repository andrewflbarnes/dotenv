return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        config = function()
          require('telescope').load_extension('fzf')
        end
      },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('telescope').load_extension('ui-select')
    end,
  },
}
