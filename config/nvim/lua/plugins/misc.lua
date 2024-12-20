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
}
