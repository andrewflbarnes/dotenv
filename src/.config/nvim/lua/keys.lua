local map = vim.api.nvim_set_keymap

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
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 bash <CR> ", {})
map('n', "t", ":FloatermToggle myfloat<CR>", {})
map('t', "<Esc><Esc>", "<C-\\><C-n>:q<CR>", {})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)

-- Nvim Tree
vim.keymap.set('n', '<leader>T', ':NvimTreeToggle<CR>', {})
vim.keymap.set({ 'n', 'v', 'i' }, '<M-F1>1', '<Cmd>NvimTreeFindFile<CR>', {})
vim.keymap.set({ 'n', 'v', 'i' }, '<F49>1', '<Cmd>NvimTreeFindFile<CR>', {})

-- Jdtls
vim.cmd([[
nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap ø <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

nnoremap <A-CR> <Cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <A-CR> <Esc><Cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>ac <Cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <leader>ac <Esc><Cmd>lua vim.lsp.buf.code_action()<CR>
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

-- rest
vim.keymap.set('n', '<leader>rr', function() require'rest-nvim'.run() end)
vim.keymap.set('n', '<leader>rp', function() require'rest-nvim'.run(true) end)
