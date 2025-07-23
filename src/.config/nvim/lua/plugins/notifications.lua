return {
  "rcarriga/nvim-notify",
  events = { "VeryLazy" },
  config = function()
    local notify = require("notify")
    notify.setup({})
    vim.notify = notify
  end
}
