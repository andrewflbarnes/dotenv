-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_banner = 0
vim.loader.enable()

-- shim if vim.uv doesn't exist
if vim.uv == nil then
  vim.uv = vim.loop
end

require('plug')
require('opts')
require('keys')

if vim.fn.isdirectory(vim.fn.stdpath('config') .. '/lua/corporate/init.lua') ~= 0 then
  require('corporate')
end

-- LSP Diagnostics Options Setup
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "Error",
      [vim.diagnostic.severity.WARN] = "Warn",
      [vim.diagnostic.severity.INFO] = "Info",
      [vim.diagnostic.severity.HINT] = "Hint",
    },
  },
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})
