-- todo - determine when to load
return {
  {
    'rmagatti/auto-session',
    --lazy = false,
    config = function()
      require('auto-session').setup({
        cwd_change_handling = {
          post_cwd_changed_hook = function()
            require('lualine').refresh()
            local ntapi = require 'nvim-tree.api'
            ntapi.tree.close()
            ntapi.tree.open({ path = vim.loop.cwd() })
          end
        }
      })
      vim.keymap.set("n", "<leader>fs", function() require("auto-session.session-lens").search_session() end)
    end
  }
}
