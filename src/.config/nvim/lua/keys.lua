-- movement
vim.keymap.set('v', '<S-UP>', ':m\'<-2<CR>gv=gv')
vim.keymap.set('v', '<S-DOWN>', ':m\'>+1<CR>gv=gv')

-- prefer trouble
---- quickfix - next/prev in file
--vim.keymap.set('n', '<S-RIGHT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cafter<CR>')
--vim.keymap.set('n', '<S-LEFT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cbefore<CR>')
---- quickfix - next/prev file
--vim.keymap.set('n', '<M-RIGHT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cnfile<CR>')
--vim.keymap.set('n', '<M-LEFT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cpfile<CR>')

-- Vimspector
-- Below keymaps used for lazy loading
--nmap <F9> <cmd>call vimspector#Launch()<cr>
--map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>",{})
--map('n', "Dw", ":call vimspector#AddWatch()<cr>", {})
--map('n', "De", ":call vimspector#Evaluate()<cr>", {})
vim.cmd([[
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])

-- terminal
vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n>:q<CR>", { desc = "Escape terminal" })

-- diagnostics
vim.keymap.set('n', '<leader>ld', function() vim.diagnostic.open_float({ scope = "line" }) end, { desc = "[l]ist [d]iagnostics" })

-- jetbrians style
vim.keymap.set({ 'n', 'v' }, '<S-F6>', vim.lsp.buf.rename, { desc = "lsp rename symbol" })
vim.keymap.set({ 'n', 'v' }, '<F18>', vim.lsp.buf.rename, { desc = "lsp rename symbol" })
vim.keymap.set({ 'n', 'v' }, '<M-CR>', vim.lsp.buf.code_action, { desc = "code actions" })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', vim.lsp.buf.code_action, { desc = "[a]ction - [c]ode actions" })

-- Jdtls
vim.cmd([[
nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap ø <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
]])

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- auto-session
--vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, {
--  noremap = true,
--  desc = "[F]ind [S]ession"
--})
