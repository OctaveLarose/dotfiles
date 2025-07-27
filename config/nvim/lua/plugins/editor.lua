return {

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
  {
    "okuuva/auto-save.nvim",
    version = '^1.0.0',        -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle",          -- optional for lazy loading on command
    -- event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    event = { "InsertLeave" }, -- optional for lazy loading on trigger events
    opts = {
      condition = function(buf)
        local fn = vim.fn
        local filepath = fn.expand('%:p')
        local filetype = fn.getbufvar(buf, "&filetype")

        if vim.list_contains({ "tex", "bib" }, filetype) then
          return false
        end
        if filepath:match('^/home/octavel/.config/nvim') then
          return false
        end

        return true
      end

    },
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
        duration_multiplier = 0.5 -- faster than the default
      })
    end,
    opts = {},
  },

  -- {
  --   "declancm/cinnamon.nvim",
  --   version = "*",
  --   init = function()
  --     require("cinnamon").setup()
  --   end
  -- },

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

  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    config = true,
    -- autosave = true,
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

  -- better quickfix list
  { 'kevinhwang91/nvim-bqf' }

  -- makes delete not yank + defines a "cut" explicitly
  -- {
  --   "gbprod/cutlass.nvim",
  --   opts = {
  --     cut_key = "m",
  --     override_del = true
  --   }
  -- }
}
