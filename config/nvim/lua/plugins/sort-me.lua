return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    opts = require "configs.conform",
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
  },

  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    config = true,
    autosave = true,
  },

  -- { 'akinsho/toggleterm.nvim', version = "*", config = true },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },

  { 'akinsho/git-conflict.nvim', version = "*", config = true },

  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      });
    end
  },

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
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      -- {
      --   "<leader>cs",
      --   "<cmd>Trouble symbols toggle focus=false<cr>",
      --   desc = "Symbols (Trouble)",
      -- },
      -- {
      --   "<leader>cl",
      --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      --   desc = "LSP Definitions / references / ... (Trouble)",
      -- },
      -- {
      --   "<leader>xL",
      --   "<cmd>Trouble loclist toggle<cr>",
      --   desc = "Location List (Trouble)",
      -- },
      -- {
      --   "<leader>xQ",
      --   "<cmd>Trouble qflist toggle<cr>",
      --   desc = "Quickfix List (Trouble)",
      -- },
    },
  },

  {
    "petertriho/nvim-scrollbar",
    init = function()
      require("scrollbar").setup()
    end
  },

  -- TODO customise - sounds fantastic.
  {
    "FabianWirth/search.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" }
  },

  { "ThePrimeagen/vim-be-good" }
}
