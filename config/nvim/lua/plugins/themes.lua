return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      require('onedark').setup {
        -- style = 'warmer'
        -- style = 'deep'
        style = 'darker',
        diagnostics = {
          darker = false,
          undercurl = true,
          background = true,
        },
      }
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000
  },

  { "rebelot/kanagawa.nvim" },

  { "tanvirtin/monokai.nvim" },

  {
    "rose-pine/neovim",
    name = "rose-pine",
  },

  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
  },

  {
    "Kaikacy/Lemons.nvim",
    version = "*",
    lazy = false,
    priority = 1000,
    -- config = function()
    -- vim.cmd.colorscheme("lemons")
    -- end
  },

  {
    'alexpasmantier/hubbamax.nvim',
    lazy = false,
    priority = 1000,
  }
}
