require "nvchad.options"

local o = vim.o
o.cursorlineopt = 'both'

-- changing the dap default icons
vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
