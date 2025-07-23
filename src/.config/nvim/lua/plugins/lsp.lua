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
          'jdtls', 'rust_analyzer', 'ts_ls', 'awk_ls', 'ansiblels', 'arduino_language_server', 'bashls',
          'clangd', 'neocmake', 'cssmodules_ls', 'dockerls', 'docker_compose_language_service',
          'eslint', 'gradle_ls', 'graphql', 'html', 'helm_ls', 'jsonls', 'jqls', 'lua_ls', 'marksman',
          'spectral', 'perlnavigator', 'prismals', 'pylsp', 'sqls', 'taplo', 'terraformls', 'volar',
          'lemminx', 'yamlls', 'zls'
        }
      }
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require("mason-lspconfig").setup_handlers {
        function(server_name)  -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities
          })
        end,
        ["jdtls"] = function() end,          -- use nvim-jdtls instead
        ["rust_analyzer"] = function() end,  -- rely on rust-tools
        ["denols"] = function()
          local nvim_lsp = require("lspconfig");
          nvim_lsp.denols.setup {
            --on_attach = on_attach,
            capabilities = capabilities,
            root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
          }
        end,
        ["ts_ls"] = function()
          local nvim_lsp = require("lspconfig");
          local mason_volar = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin'
          nvim_lsp.ts_ls.setup {
            filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "javascript.jsx", "typescript.tsx" },
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = mason_volar,
                  languages = { "vue", "javascript", "typescript" },
                },
              },
            },
            --on_attach = on_attach,
            capabilities = capabilities,
            root_dir = nvim_lsp.util.root_pattern("package.json"),
            single_file_support = false,
          }
        end,
        ["volar"] = function()
          require("lspconfig").volar.setup({
        --    --filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        --    init_options = {
        --      vue = {
        --        hybridMode = false,
        --      },
        --      typescript = {
        --        tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
        --      },
        --    },
          })
        end,
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
