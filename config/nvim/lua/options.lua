local opt = vim.opt
local o = vim.o
local g = vim.g
local wo = vim.wo
local lsp = vim.lsp

-- Misc general options
o.mouse = "a"                 -- mouse enabled
o.undofile = true             -- we want an undofile
o.timeoutlen = 400            -- mapped sequences time out after 400 ms
o.signcolumn = "yes"          -- always show signcolumn (warnings etc., left of cursorline)
o.updatetime = 250            -- interval for writing swap file to disk, also used by gitsigns
-- o.clipboard = "unnamedplus" -- not sure i like sharing the clipboard with the system...
opt.whichwrap:append "<>[]hl" -- go to previous/next line with h,l,left,right when cursor reaches end/start of line
opt.swapfile = false

-- PURGATORY FOR OPTIONS
-- o.winborder = "rounded" -- does this do anything for us?

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

-- case insensitivity
o.ignorecase = true
o.smartcase = true -- "Override the 'ignorecase' option if the search pattern contains upper case characters."

-- highlight the cursor line and its number
o.cursorline = true
o.cursorlineopt = 'both'

-- Show line numbers
o.number = true
o.numberwidth = 10
wo.relativenumber = true -- relative line numbers (:set rnu! toggles this on/off)

-- we don't need vim to add characters to separators/statuslines/etc.
opt.fillchars = { eob = " " } -- default "~" for eob is iconic but hey

-- split below/right by default
o.splitbelow = true
o.splitright = true

-- lualine does these for us
o.ruler = false    -- don't show current position
o.showmode = false -- don't show insert/replace/etc

-- status line (name) only for last window, otherwise it clutters
o.laststatus = 3

-- disable nvim intro
opt.shortmess:append "sI"

-- disable some default language providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path (not sure we use/need that to be honest)
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- nvim LSP stuff
lsp.inlay_hint.enable()
