vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- for nvimtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.opt.termguicolors = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- hmm, maybe restore? TODO
-- local lazy_config = require "configs.lazy"

require('lazy').setup {
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

vim.cmd [[colorscheme onedark]]

require("mason").setup()

-- load nvchad theme
-- dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline")

require "options"
-- require "nvchad.autocmds"

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

-- workaround for bug with rust-analyzer notification
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end

vim.api.nvim_set_hl(0, "FlashLabel", { fg = "black", bg = "#cd78dd" })

-- local timer = nil
-- show precognition hints after a sec of inactivity
-- vim.api.nvim_create_autocmd({ "CursorMoved" }, { -- "CursorMovedI"
--   callback = function()
--     local function on_cursor_idle()
--       require('precognition').peek()
--     end
--
--     if timer then
--       timer:stop()
--       timer:close()
--     end
--
--     timer = vim.loop.new_timer()
--     timer:start(5000, 0, vim.schedule_wrap(on_cursor_idle))
--   end
-- })
