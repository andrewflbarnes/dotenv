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
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
