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
        ------- what follows is now part of the default config, I think?
        -- tools = {
        --   on_initialized = function()
        --   vim.cmd([[
        --         augroup RustLSP
        --           autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
        --           autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
        --           autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
        --         augroup END
        --       ]])
        -- end
        -- }
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
      require('crates').setup()
    end
  },
}
