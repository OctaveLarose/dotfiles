return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    ft = "rust",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              diagnostics = {
                disabled = { "inactive-code" }
              }
            },
          },
        }
      }
    end
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    -- init = function()
    --   vim.g.rustfmt_autosave = 1 -- automatically format on file save!
    -- end
  },

  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup({})
    end
  },

  -- TODO - set up autocmd for that
  {
    "alexpasmantier/krust.nvim",
    ft = "rust",
    opts = {
      keymap = "<leader>k", -- Set a keymap for Rust buffers (default: false)
      float_win = {
        -- border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
        -- auto_focus = false, -- Auto-focus float (default: false)
      },
    },
  }
}
