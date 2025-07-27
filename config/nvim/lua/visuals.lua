vim.cmd [[colorscheme ayu-mirage]]

require("smear_cursor").toggle()

vim.api.nvim_set_hl(0, "FlashLabel", { fg = "black", bg = "#cd78dd" })
-- vim.api.nvim_set_hl(0, "FlashCursor", { fg = "black", bg = "#1100ff" }) -- experimenting with clearer f/t search results
vim.api.nvim_set_hl(0, "LineNr", { fg = "#8B8B8B" }) -- more visible line numbers

-- changing the dap default icons
vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
