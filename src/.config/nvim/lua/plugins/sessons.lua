return {
  {
    'rmagatti/auto-session',
    config = function()
      require 'auto-session' .setup {
        cwd_change_handling = {
          post_cwd_changed_hook = function()
            require 'lualine' .refresh()
            -- local ntapi = require 'nvim-tree.api'
            -- ntapi.tree.close()
            -- ntapi.tree.open({ path = vim.loop.cwd() })
          end
        }
      }
    end
  }
}
