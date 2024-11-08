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
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '/' },
      -- log_level = 'debug',
    }
  },

  { 'akinsho/toggleterm.nvim', version = "*", config = true },

  {
    'lambdalisue/vim-suda',
    config = function()
      vim.g.suda_smart_edit = 1
      -- Expand 'ss' into 'SudaWrite' in the command line
      vim.cmd([[cab ss SudaWrite]])
    end,
  },

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
}
