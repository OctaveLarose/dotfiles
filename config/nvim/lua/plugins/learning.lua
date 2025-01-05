return {
  {
    "tris203/precognition.nvim",
    init = function()
      require('precognition').toggle()
    end,
    opts = {
      startVisible = true,
    }
  },

  { "ThePrimeagen/vim-be-good" },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
  },

}
