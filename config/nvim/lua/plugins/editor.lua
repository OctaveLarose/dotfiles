return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
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

  -- status bar
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          disabled_filetypes = { "snacks_dashboard" },
          -- disabled_filetypes = { "snacks_dashboard", "NvimTree" },
          -- extensions = { "nvim-tree" }
        }
      })
    end
  },

  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    config = true,
    autosave = true,
  },

  {
    "nvim-tree/nvim-tree.lua",
    init = function()
      require("nvim-tree").setup()
    end
    -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  },

  {
    "nvim-tree/nvim-web-devicons",
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.nvim-cmp"
    end,
  },

}
