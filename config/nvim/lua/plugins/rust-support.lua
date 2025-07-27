return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    ft = "rust",
    dependencies = { "williamboman/mason.nvim", "adaszko/tree_climber_rust.nvim" },
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
          on_attach = function(_client, bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-w>', '<cmd>lua require("tree_climber_rust").init_selection()<CR>',
              opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'x', '<C-w>',
              '<cmd>lua require("tree_climber_rust").select_incremental()<CR>',
              opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'x', '<BS>',
              '<cmd>lua require("tree_climber_rust").select_previous()<CR>',
              opts)
          end,
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
      require('crates').setup({})
    end
  },
}
