local lu = require("lazyutils")

local keys = lu.lazy_keys(function(trouble)
  local trouble_open = function()
    if not trouble.is_open() then
      trouble.open("diagnostics")
    end
  end
  local open_and_prev = function()
    trouble_open()
    trouble.prev({ skip_groups = true, jump = true })
  end
  local open_and_next = function()
    trouble_open()
    trouble.next({ skip_groups = true, jump = true })
  end
  local open_and_first = function()
    trouble_open()
    trouble.first({ skip_groups = true, jump = true })
  end
  local open_and_last = function()
    trouble_open()
    trouble.last({ skip_groups = true, jump = true })
  end
  return {
    { "n", "<leader>xx", ":Trouble diagnostics toggle<CR>", { desc = "trouble toggle" } },
    { "n", "<leader>xs", ":Trouble symbols toggle<CR>", { desc = "trouble [s]ymbols" } },
    { "n", "<leader>xr", ":Trouble lsp_references<CR>", { desc = "trouble lsp [r]eferences" } },
    { "n", "<leader>xd", ":Trouble lsp_definitions<CR>", { desc = "trouble lsp [d]efinitions" } },
    { "n", "<leader>xt", ":Trouble lsp_type_definitions<CR>", { desc = "trouble lsp [t]ypes" } },
    { "n", "<leader>xi", ":Trouble lsp_implementations<CR>", { desc = "trouble lsp [i]mplementations" } },
    { "n", "<leader>xc", ":Trouble diagnostics open filter.buf=0<CR>", { desc = "trouble do[c] diagnostics" } },
    { "n", "<leader>xw", ":Trouble diagnostics open filter = {}<CR>", { desc = "trouble [w]orkspace diagnostics" } },
    { "n", "<S-RIGHT>", open_and_next, { desc = "trouble next" } },
    { "n", "<leader>xl", open_and_last, { desc = "trouble [l]ast" } },
    { "n", "<S-LEFT>", open_and_prev, { desc = "trouble prev" } },
    { "n", "<leader>xf", open_and_first, { desc = "trouble [f]irst" } },
  }
end)

return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = keys:triggers(),
    opts = {
      mode = 'document_diagnostics'
    },
    config = function()
      local trouble = require("trouble")
      trouble.setup {}
      keys:map_keys(trouble)
    end
  },
}
