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
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { 'jdtls', 'rust-analyzer', 'codelldb', 'shellcheck' }
      }
      
      require("mason-lspconfig").setup_handlers {
        function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,
        ["jdtls"] = function () end, -- use nvim-jdtls instead
        ["rust_analyzer"] = function () end, -- rely on rust-tools
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "rust", "toml" },
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
        }
      }
    end,
  },

  "neovim/nvim-lspconfig",

  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust-tools")
      
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
  },

    -- Completion framework:
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Add tab support
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        },
        -- Installed sources:
        sources = {
          { name = 'path' },                              -- file paths
          { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
          { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
          { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
          { name = 'buffer', keyword_length = 2 },        -- source current buffer
          { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
          { name = 'calc'},                               -- source for math calculation
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            fields = {'menu', 'abbr', 'kind'},
            format = function(entry, item)
                local menu_icon ={
                    nvim_lsp = 'λ',
                    vsnip = '⋗',
                    buffer = 'Ω',
                    path = '𝑓',
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
        },
      })
    end,
  },

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

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signcolumn = false,
        numhl = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
      }
    end,
  },

  {
    "lewis6991/impatient.nvim",
    config = function()
      require('impatient')
    end,
  },

  "mfussenegger/nvim-jdtls",
})
