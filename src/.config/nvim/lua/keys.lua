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
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 bash <CR>", { desc = "[F]loat [T]erm" })
map('n', "t", ":FloatermToggle myfloat<CR>", {})
map('t', "<Esc><Esc>", "<C-\\><C-n>:q<CR>", {})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "[F]ind [G]rep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set('n', '<F60>', builtin.lsp_document_symbols, { desc = "lsp document symbols" })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = "[F]ind [R]eferences" })

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Trouble" })

-- Nvim Tree
vim.keymap.set('n', '<leader>T', ':NvimTreeToggle<CR>', { desc = "[T]oggle NvimTree"})
vim.keymap.set('n', '<F49>1', ':NvimTreeFindFile<CR>', { desc = "Find file in NvimTree" })

-- Gitsigns
vim.keymap.set('n', 'gsp', ':Gitsigns preview_hunk<CR>', { desc = "[G]it[S]igns [P]review hunk" })

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
vim.keymap.set({ 'n', 'v' }, '<M-CR>', vim.lsp.buf.code_action)
vim.keymap.set({ 'n', 'v' }, '<leader>ac', vim.lsp.buf.code_action, { desc = "[A]ction - [C]ode actions" })

-- rest
vim.keymap.set('n', '<leader>rr', function() require'rest-nvim'.run() end, { desc = "[R]est [R]un" })
vim.keymap.set('n', '<leader>rp', function() require'rest-nvim'.run(true) end, { desc = "[R]est [P]review" })

-- auto-session
vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, {
  noremap = true,
  desc = "[F]ind [S]ession"
})
