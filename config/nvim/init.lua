vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- relative line numbers (there's a mapping to toggle it on/off also)
vim.wo.relativenumber = true

-- vim.g.
--     set
-- rnu

-- bootstrap lazy and all plugins
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

vim.cmd [[colorscheme ayu-mirage]]

require("mason").setup()

require "options"

vim.schedule(function()
  require "mappings"
end)

vim.lsp.inlay_hint.enable()

require "visuals"

require "autocmds"
