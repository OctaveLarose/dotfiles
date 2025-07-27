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
  { 'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  { import = "plugins" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  }
}

----- Done with lazy/plugin setup. -----

require "options"
require "mappings"
require "visuals"
require "autocmds"

-- we scheduled the setup of mappings in the past, but I'm no longer sure it's worth it.
-- vim.schedule(function()
--   require "mappings"
-- end)
