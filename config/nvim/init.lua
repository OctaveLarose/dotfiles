-- needed first and foremost, because requested by lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-----  Bootstrap lazy and all plugins -----
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- install = { colorscheme = { "ayu-mirage" } },
  { import = "plugins" },
}

----- Done with lazy/plugin setup. -----

require "options"
require "mappings" -- we vim.schedule()'d mappings in the past, but I'm no longer sure it's worth it.
require "visuals"
require "autocmds"
