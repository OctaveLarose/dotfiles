return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    opts = require "configs.conform",
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      -- json = { lsp_format = "prefer" }
    },
  },

  {
    "okuuva/auto-save.nvim",
    version = '^1.0.0',        -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle",          -- optional for lazy loading on command
    -- event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    event = { "InsertLeave" }, -- optional for lazy loading on trigger events
    opts = {},
    condition = function(buf)
      local fn = vim.fn
      local filepath = fn.expand('%:p')

      if not filepath:match('^/home/octavel/.config/nvim') then
        return true
      end
      return false
    end
  },

  {
    "petertriho/nvim-scrollbar",
    init = function()
      require("scrollbar").setup()
    end
  },

  {
    "karb94/neoscroll.nvim",
    init = function()
      require("neoscroll").setup({
        duration_multiplier = 0.8 -- a bit faster than the default
      })
    end,
    opts = {},
  },

  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    config = true,
    autosave = true,
  },
}
