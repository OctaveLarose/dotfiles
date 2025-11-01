-- NB: Rust handled through rustaceanvim

vim.lsp.enable("lua_ls") -- NB: lazydev does the config for us, for nvim config editing.
vim.lsp.enable("markdown_oxide")
vim.lsp.enable("jsonls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruby_lsp")
vim.lsp.enable("clangd")
-- lspconfig.typos_lsp.setup {}
-- lspconfig.texlab.setup {}
