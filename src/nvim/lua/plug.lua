local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  "nvim-treesitter/nvim-treesitter",

  "neovim/nvim-lspconfig",

  "simrat39/rust-tools.nvim",

    -- Completion framework:
  "hrsh7th/nvim-cmp",

  -- LSP completion source:
  "hrsh7th/cmp-nvim-lsp",

  -- Useful completion sources:
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "hrsh7th/vim-vsnip",

  {
    "puremourning/vimspector",
    lazy = true,
    keys = {
	{ "<F9>", ":call vimspector#Launch()<cr>" },
	{ "Db", ":call vimspector#ToggleBreakpoint()<cr>" },
        { "Dw", ":call vimspector#AddWatch()<cr>" },
        { "De", ":call vimspector#Evaluate()<cr>" },
    },
  },

  "voldikss/vim-floaterm",
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
      'nvim-telescope/telescope-ui-select.nvim',
    }
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  "lewis6991/gitsigns.nvim",

  "lewis6991/impatient.nvim",

  "mfussenegger/nvim-jdtls",
})
