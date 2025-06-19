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
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
