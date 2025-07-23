return {
  {
    "neovim/nvim-lspconfig",
    event = { 'BufNewFile', 'BufReadPost', 'VeryLazy' },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local nvim_lsp = require("lspconfig");
      vim.lsp.config["denols"] = {
        capabilities = capabilities,
        root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
      }
      vim.lsp.config["ts_ls"] = {
        capabilities = capabilities,
        --root_dir = nvim_lsp.util.root_pattern("package.json"),
        workspace_required = true,
      }
      --["volar"] = function()
      --  require("lspconfig").volar.setup({
      --    filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
      --    init_options = {
      --      vue = {
      --        hybridMode = false,
      --      },
      --      typescript = {
      --        tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
      --      },
      --    },
      --  })
      --end,
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        }
      })

      require("mason-lspconfig").setup {
        ensure_installed = {
          'jdtls', 'rust_analyzer','ts_ls', 'awk_ls', 'ansiblels', 'arduino_language_server', 'bashls',
          'clangd','cssmodules_ls', 'denols', 'dockerls', 'docker_compose_language_service',
          --'neocmake',
          'eslint', 'gradle_ls', 'graphql', 'html', 'helm_ls', 'jsonls', 'jqls', 'lua_ls', 'marksman',
          --'spectral',
          'perlnavigator', 'prismals', 'pyright', 'sqls', 'taplo', 'terraformls',
          -- 'volar',
          'lemminx', 'yamlls', 'zls'
        },
        automatic_enable = {
          exclude = {
            "jdtls",
            "rust_analyzer",
          }
        }
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
            vim.keymap.set("n", "<Leader>ac", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
  },
}
