vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- to use the normal clipboard, in theory
vim.api.nvim_set_option_value("clipboard", "unnamed,unnamedplus", {})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--     pattern = {"*"},
--     callback = function(_)
--         -- save_cursor = vim.fn.getpos(".")
--         -- vim.cmd([[%s/\s\+$//e]])
--         -- vim.fn.setpos(".", save_cursor)
--
--         -- autoformat
--         local mode = vim.api.nvim_get_mode().mode
--         if vim.bo.modified == true and mode == 'n' then
--             vim.cmd('lua vim.lsp.buf.format()')
--         else
--     end
--   end,
-- })

-- autoformat
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

