return {

  "debugloop/telescope-undo.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>fu", ":Telescope undo<CR>" , desc = "[f]ind [u]ndo" },
  },
  opts = {
    extensions = {
      undo = {
      }
    }
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("undo")
  end
}

