return {
  -- autoformatting
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      -- json = { lsp_format = "prefer" }
    },
  },

  -- autosave files
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
    "declancm/cinnamon.nvim",
    version = "*",
    init = function()
      require("cinnamon").setup()
    end
  },

  -- status bar
  -- maybe https://github.com/bwpge/lualine-pretty-path is nice
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

  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   init = function()
  --     require("nvim-tree").setup()
  --   end
  --   -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  -- },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = {
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time -- -- the current file is changed while the tree is open.
        }
      }
    }
  },

  -- makes delete not yank + defines a "cut" explicitly
  -- {
  --   "gbprod/cutlass.nvim",
  --   opts = {
  --     cut_key = "m",
  --     override_del = true
  --   }
  -- }
}
