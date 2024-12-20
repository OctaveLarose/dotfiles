return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    ft = "rust",
    config = function()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
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
