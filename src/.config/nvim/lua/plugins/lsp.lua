return {
  "neovim/nvim-lspconfig",
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
        ensure_installed = {
          'jdtls', 'rust_analyzer','tsserver', 'awk_ls', 'ansiblels', 'arduino_language_server', 'bashls',
          'clangd', 'neocmake', 'cssmodules_ls', 'denols', 'dockerls', 'docker_compose_language_service',
          'eslint', 'gradle_ls', 'graphql', 'html', 'helm_ls', 'jsonls', 'jqls', 'lua_ls', 'marksman',
          'spectral', 'perlnavigator', 'prismals', 'pyright', 'sqls', 'taplo', 'terraformls', 'volar',
          'lemminx', 'yamlls', 'zls'
        }
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
}
