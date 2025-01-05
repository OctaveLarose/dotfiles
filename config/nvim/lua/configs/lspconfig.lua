-- -- -- load defaults i.e lua_lsp
-- -- require("nvchad.configs.lspconfig").defaults()
-- --
local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

--
-- local servers = {} -- none at the moment, we just need rust which we handle through rustaceanvim
-- local nvlsp = require "nvchad.configs.lspconfig"
--
-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = nvlsp.on_attach,
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--   }
-- end
--
-- -- configuring single server, example: typescript
-- -- lspconfig.ts_ls.setup {
-- --   on_attach = nvlsp.on_attach,
-- --   on_init = nvlsp.on_init,
-- --   capabilities = nvlsp.capabilities,
-- -- }
