local map = vim.api.nvim_set_keymap

-- movement
vim.keymap.set('v', '<S-UP>', ':m\'<-2<CR>gv=gv')
vim.keymap.set('v', '<S-DOWN>', ':m\'>+1<CR>gv=gv')
vim.keymap.set('n', '<S-RIGHT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cafter<CR>')
vim.keymap.set('n', '<M-RIGHT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cnfile<CR>')
vim.keymap.set('n', '<S-LEFT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cbefore<CR>')
vim.keymap.set('n', '<M-LEFT>', '<Cmd>botright copen<CR><C-W><C-P><Cmd>cpfile<CR>')

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

-- FloaTerm configuration
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 bash <CR>", { desc = "[f]loat [t]erm" })
map('n', "<leader>t", ":FloatermToggle myfloat<CR>", {})
map('t', "<Esc><Esc>", "<C-\\><C-n>:q<CR>", {})

-- diagnostics
vim.keymap.set('n', '<leader>ld', function() vim.diagnostic.open_float({ scope = "line" }) end, { desc = "[l]ist [d]iagnostics" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[f]ind [f]iles" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "[f]ind [g]rep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "[f]ind [b]uffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "[f]ind [h]elp" })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = "[f]ind [r]eferences" })
vim.keymap.set('n', '<leader>fq', builtin.quickfixhistory, { desc = "[f]ind [q]uickfix history" })
vim.keymap.set('n', '<leader>fQ', builtin.quickfix, { desc = "[f]ind [Q]uickfixes" })

-- jetbrians style
vim.keymap.set('n', '<F60>', builtin.lsp_document_symbols, { desc = "lsp document symbols" })
vim.keymap.set('n', '<M-F12>', builtin.lsp_document_symbols, { desc = "lsp document symbols" })
vim.keymap.set({ 'n', 'v' }, '<S-F6>', vim.lsp.buf.rename, { desc = "lsp rename symbol" })
vim.keymap.set({ 'n', 'v' }, '<F18>', vim.lsp.buf.rename, { desc = "lsp rename symbol" })
vim.keymap.set({ 'n', 'v' }, '<M-CR>', vim.lsp.buf.code_action, { desc = "code actions" })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', vim.lsp.buf.code_action, { desc = "[a]ction - [c]ode actions" })

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "[xx] Trouble" })

-- Nvim Tree
vim.keymap.set('n', '<leader>T', ':NvimTreeToggle<CR>', { desc = "toggle Nvim[T]ree"})
vim.keymap.set('n', '<F49>1', ':NvimTreeFindFile<CR>', { desc = "Find file in NvimTree" })
vim.keymap.set('n', '<M-F1>1', ':NvimTreeFindFile<CR>', { desc = "Find file in NvimTree" })

-- Gitsigns
vim.keymap.set({ 'n', 'v' }, 'gsb', ':Gitsigns toggle_current_line_blame<CR>', { desc = "[g]it[s]igns toggle [b]lame" })
vim.keymap.set({ 'n', 'v' }, 'gsn', ':Gitsigns next_hunk<CR>', { desc = "[g]it[s]igns [n]ext hunk" })
vim.keymap.set({ 'n', 'v' }, 'gsp', ':Gitsigns preview_hunk<CR>', { desc = "[g]it[s]igns [p]review hunk" })
vim.keymap.set({ 'n', 'v' }, 'gsr', ':Gitsigns reset_hunk<CR>', { desc = "[g]it[s]igns [r]eset hunk" })
vim.keymap.set({ 'n', 'v' }, 'gst', function ()
    local tog = not vim.g.gitsigns_toggled
    require('gitsigns').setup({
        linehl = tog,
        word_diff = tog,
        show_deleted = tog,
    })
    vim.g.gitsigns_toggled = tog
    vim.cmd('Gitsigns refresh')
end, { desc = "[g]it[s]igns [t]oggle" }, { noremap = true })

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

vim.keymap.set({ 'n', 'v' }, '<F18>', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, '<S-F6>', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, '<M-CR>', vim.lsp.buf.code_action)
vim.keymap.set({ 'n', 'v' }, '<leader>ac', vim.lsp.buf.code_action, { desc = "[A]ction - [C]ode actions" })
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

-- rest
vim.keymap.set('n', '<leader>rr', function() require'rest-nvim'.run() end, { desc = "[r]est [r]un" })
vim.keymap.set('n', '<leader>rp', function() require'rest-nvim'.run(true) end, { desc = "[r]est [p]review" })

-- auto-session
vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, {
  noremap = true,
  desc = "[f]ind [s]ession"
})
