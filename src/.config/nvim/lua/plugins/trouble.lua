local lu = require("lazyutils")

local keys = lu.lazy_keys(function(trouble)
  local trouble_open = function()
    if not trouble.is_open() then
      trouble.open()
    end
  end
  local open_and_prev = function()
    trouble_open()
    trouble.previous({ skip_groups = true, jump = true })
    trouble_open()
  end
  local open_and_next = function()
    trouble_open()
    trouble.next({ skip_groups = true, jump = true })
    trouble_open()
  end
  return {
    { "n", "<leader>xx", ":TroubleToggle<CR>", { desc = "trouble toggle" } },
    { "n", "<leader>xr", ":Trouble lsp_references<CR>", { desc = "trouble lsp [r]eferences" } },
    { "n", "<leader>xd", ":Trouble lsp_definitions<CR>", { desc = "trouble lsp [d]efinitions" } },
    { "n", "<leader>xt", ":Trouble lsp_type_definitions<CR>", { desc = "trouble lsp [t]ypes" } },
    { "n", "<leader>xi", ":Trouble lsp_implementations<CR>", { desc = "trouble lsp [i]mplementations" } },
    { "n", "<leader>xc", ":Trouble document_diagnostics<CR>", { desc = "trouble do[c] diagnostics" } },
    { "n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", { desc = "trouble [w]orkspace diagnostics" } },
    { "n", "<S-RIGHT>", open_and_next, { desc = "trouble next" } },
    { "n", "<S-LEFT>", open_and_prev, { desc = "trouble prev" } },
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
      keys:map_keys(require("trouble"))
    end
  },
}
