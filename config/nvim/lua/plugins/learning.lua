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

  {
    'szymonwilczek/vim-be-better',
    -- config = function()
    --   -- Optional: Enable logging for debugging
    --   vim.g.vim_be_better_log_file = 1
    -- end
  },

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

  -- i don't feel like i need it anymore
  -- {
  --   "m4xshen/hardtime.nvim",
  --   lazy = false,
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = {
  --     disabled_keys = {
  --       ["<Up>"] = false, -- I use them in nvim-cmp menus
  --       ["<Down>"] = false
  --     }
  --   }
  -- },
}
