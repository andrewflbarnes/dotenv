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
map('t', "<Esc>", "<C-\\><C-n>:q<CR>", {})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)

-- Nvim Tree
vim.keymap.set('n', '<leader>T', ':NvimTreeToggle <CR>', {})

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
