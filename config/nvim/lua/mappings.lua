require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>:w<CR>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Toggleterm
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new(
  {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = { border = "double" }
  }
)

function _lazygit_toggle()
  lazygit:toggle()
end

map("n", "<leader>gi", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

local bufnr = vim.api.nvim_get_current_buf()
map("n", "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)