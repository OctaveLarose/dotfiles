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

vim.lsp.inlay_hint.enable()

-- autoformat
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- to not capture when saving sessions:
-- NvimTree
-- dapui
vim.api.nvim_create_autocmd("User", {
  pattern = "PersistedSavePre",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].filetype == "NvimTree" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
    require("dapui").close()
  end,
})
