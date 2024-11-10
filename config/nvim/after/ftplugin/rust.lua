local bufnr = vim.api.nvim_get_current_buf()

--- Rusteaceanvim stuff

vim.keymap.set("n", "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction')
    -- or vim.lsp.buf.codeAction() for no rust-analyzer grouping
  end,
  { silent = true, buffer = bufnr, desc = "RustLsp code action" }
)

vim.keymap.set("n", "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'hover', 'actions' })
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>",
  { desc = "Debugger testables" }
)
