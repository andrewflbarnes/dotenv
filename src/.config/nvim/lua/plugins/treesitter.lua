return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    --lazy = false,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "rust", "toml", "html", "json" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting=false,
        },
        ident = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "v",
            node_decremental = "V",
          },
        },
      }
    end,
  },
}
