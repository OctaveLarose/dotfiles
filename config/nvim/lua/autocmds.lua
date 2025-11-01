-- Autoformatting.
-- Simpler, more/too generic version: vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local mode = vim.api.nvim_get_mode().mode
    local filetype = vim.bo.filetype
    if vim.bo.modified == true and mode == 'n' and not vim.list_contains({ "markdown", "tex", "bib" }, filetype) then
      -- we shouldn't -have- to use conform... But it works better than the default formatter, at the moment, as far as I can tell.
      -- vim.cmd('lua vim.lsp.buf.format()')
      require("conform").format({ bufnr = args.buf, lsp_format = "fallback" })
    else
    end
  end
})

-- To not capture when saving sessions: NvimTree/neotree, dapui
vim.api.nvim_create_autocmd("User", {
  pattern = "PersistedSavePre",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].filetype == "NvimTree" or vim.bo[buf].filetype == "neo-tree" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
    require("dapui").close()
  end,
})

-- I don't like undofiles persisting past vim closing, personally
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local undodir = vim.opt.undodir:get()[1]
    if undodir and undodir ~= "" then
      vim.fn.delete(undodir, "rf")
    end
  end,
})

-- Show LSP loading progress.
-- vim.api.nvim_create_autocmd("LspProgress", {
--   ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--   callback = function(ev)
--     local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--     vim.notify(vim.lsp.status(), "info", {
--       id = "lsp_progress",
--       title = "LSP Progress",
--       opts = function(notif)
--         notif.icon = ev.data.params.value.kind == "end" and " "
--             or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--       end,
--     })
--   end,
-- })
