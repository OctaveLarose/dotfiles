-- needed first and foremost, because requested by lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- shouldn't have to do this, but it doesn't know e.g. fzf otherwise?
local nix_paths = vim.fn.expand("~/.nix-profile/bin") .. ":/nix/var/nix/profiles/default/bin"
vim.env.PATH = nix_paths .. ":" .. vim.env.PATH

-----  Bootstrap lazy and all plugins -----
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = { { import = "plugins" } },

  install = { colorscheme = { "ayu-mirage" } },
  -- install = { colorscheme = { "habamax" } },

  -- checker = { enabled = true }, -- automatically check for plugin updates
}

----- Done with lazy/plugin setup. -----

require "options"
require "mappings" -- we vim.schedule()'d mappings in the past, but I'm no longer sure it's worth it.
require "visuals"
require "autocmds"
