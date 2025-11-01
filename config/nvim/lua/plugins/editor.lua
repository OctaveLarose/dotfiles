return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  -- for easier nvim dev/config tweaking
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- autosave files
  -- {
  --   "okuuva/auto-save.nvim",
  --   version = '^1.0.0',        -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
  --   cmd = "ASToggle",          -- optional for lazy loading on command
  --   -- event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  --   event = { "InsertLeave" }, -- optional for lazy loading on trigger events
  --   opts = {
  --     condition = function(buf)
  --       local fn = vim.fn
  --       local filepath = fn.expand('%:p')
  --       local filetype = fn.getbufvar(buf, "&filetype")
  --
  --       if vim.list_contains({ "tex", "bib" }, filetype) then
  --         return false
  --       end
  --       if filepath:match('^/home/octavel/.config/nvim') then
  --         return false
  --       end
  --
  --       return true
  --     end
  --
  --   },
  -- },

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
        duration_multiplier = 0.5 -- faster than the default
      })
    end,
    opts = {},
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      insert_mappings = true,
      -- terminal_mappings = true, -- not sure about this one, it's to theoretically keep insert mode
    }
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

  -- that one huge neovim design changing/prettifying plugin
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  -- persisting sessions
  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    config = true,
    -- autosave = true,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = {
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
        }
      }
    }
  },

  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    }
  },

  -- better quickfix list, makes it a pretty floating window
  { 'kevinhwang91/nvim-bqf' }

  -- smooth scrolling
  -- {
  --   "declancm/cinnamon.nvim",
  --   version = "*",
  --   init = function()
  --     require("cinnamon").setup()
  --   end
  -- },
}
