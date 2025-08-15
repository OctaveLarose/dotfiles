local lspconfig = require "lspconfig"

-- NB: Rust handled through rustaceanvim

lspconfig.lua_ls.setup {} -- NB: lazydev does the config for us, for nvim config editing.
lspconfig.markdown_oxide.setup {}
lspconfig.jsonls.setup {}
lspconfig.pyright.setup {}
-- lspconfig.typos_lsp.setup {}
-- lspconfig.texlab.setup {}
