local lu = require('lazyutils')

local keys = lu.lazy_keys(function(c) return {
  { 'n', '<leader>ff', c.find_files, { desc = "[f]ind [f]iles" } },
  { 'n', '<leader>fg', c.live_grep, { desc = "[f]ind [g]rep" } },
  { 'n', '<leader>fG', function() c.live_grep({grep_open_files=true}) end, { desc = "[f]ind [G]rep open files" } },
  { 'n', '<leader>fb', c.buffers, { desc = "[f]ind [b]uffers" } },
  { 'n', '<leader>fh', c.help_tags, { desc = "[f]ind [h]elp" } },
  { 'n', '<leader>fr', c.lsp_references, { desc = "[f]ind [r]eferences" } },
  { 'n', '<F60>', c.lsp_document_symbols, { desc = "lsp document symbols" } },
  { 'n', '<M-F12>', c.lsp_document_symbols, { desc = "lsp document symbols" } },
  { 'n', '<leader>fq', c.quickfixhistory, { desc = "[f]ind [q]uickfix history" } },
  { 'n', '<leader>fQ', c.quickfix, { desc = "[f]ind [Q]uickfixes" } },
} end)

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'folke/trouble.nvim',
    },
    keys = keys:triggers(),
    config = function()
      local telescope = require("telescope")
      local telescopeConfig = require("telescope.config")

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to follow symlinks.
      table.insert(vimgrep_arguments, "-L")
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      telescope.load_extension('ui-select')
      telescope.load_extension('fzf')

      local actions = require("telescope.actions")
      local open_trouble = require("trouble.sources.telescope").open
      local add_trouble = require("trouble.sources.telescope").add
      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
            scroll_speed = 5,
          },
          mappings = {
            n = {
              ["<C-t>"] = open_trouble,
              ["<C-q>"] = add_trouble,
            },
            i = {
              ["<C-t>"] = open_trouble,
              ["<C-q>"] = add_trouble,
            },
          },
          path_display = { 'smart' },
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            theme = 'ivy',
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "-L", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })

      keys:map_keys(require("telescope.builtin"))
    end,
  },
}
