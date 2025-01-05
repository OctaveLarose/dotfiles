-- require "nvchad.mappings"

local map = vim.keymap.set

-- from nvchad originally:
------------------------------

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })


-- LSP stuff
local function lsp_opts(desc)
  return { buffer = bufnr, desc = "LSP " .. desc }
end

map("n", "gD", vim.lsp.buf.declaration, lsp_opts "Go to declaration")
map("n", "gd", vim.lsp.buf.definition, lsp_opts "Go to definition")
map("n", "gi", vim.lsp.buf.implementation, lsp_opts "Go to implementation")
map("n", "<leader>sh", vim.lsp.buf.signature_help, lsp_opts "Show signature help")
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, lsp_opts "Add workspace folder")
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, lsp_opts "Remove workspace folder")

map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, lsp_opts "List workspace folders")

map("n", "<leader>D", vim.lsp.buf.type_definition, lsp_opts "Go to type definition")
-- map("n", "<leader>ra", require "nvchad.lsp.renamer", lsp_opts "NvRenamer")

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lsp_opts "Code action")
map("n", "gr", vim.lsp.buf.references, lsp_opts "Show references")

------------------------------

-- tab/barbar stuff
map("n", "<tab>", "<cmd>BufferNext<cr>", { desc = "buffer goto next" })
map("n", "<S-tab>", "<cmd>BufferPrevious<cr>", { desc = "buffer goto prev" })
map("n", "<A-c>", "<cmd>BufferClose<cr>", { desc = "buffer close" })

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", "<cmd>BufferGoto " .. i .. "<CR>", { desc = "buffer goto " .. i })
end
vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<CR>", { desc = "buffer goto last" })

------------------------------

-- fzf-lua
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "fzf-lua find files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<cr>", { desc = "fzf-lua live grep" })

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>:w<CR>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Ctrl+S save" })

map("n", "<leader>rr", ":make b <cr>", { silent = true, desc = "Make build" })

map("n", "yc", "yygccp", { desc = "Copy line and comment it" })

-- LSP config. Ideally we'd want it defined just when we load the LSP
-- and if so these keys need to be shared between A) normal LSP and B) rustaceanvim invoking its own LSP
local function opts(desc)
  return { buffer = bufnr, desc = "LSP " .. desc }
end

map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })

map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
map("n", "ga", vim.lsp.buf.references, opts "Show references")
map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts "List workspace folders")

map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
-- map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
map("n", "gr", vim.lsp.buf.references, opts "Show references")

map("n", "<space>h", vim.lsp.buf.hover,
  { noremap = true, silent = true, buffer = bufnr, desc = "Hover action" }
)

-- grug-far
local grug_far = require("grug-far")
map('n', '<leader>F', function() grug_far.open() end, { desc = "Use grug-far (project wide)" })

map('v', 'ff',
  function()
    local prefill = vim.fn.expand("<cword>")
    local current_file = vim.fn.expand("%")
    grug_far.open({ prefills = { search = prefill, replacement = prefill, paths = current_file } })
    -- grug_far.open({ prefills = { search = prefill, paths = current_file } })
  end,
  { desc = "Use grug-far (on current word, in current file)" }
)

map('v', 'fff',
  function() grug_far.open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
  { desc = "Use grug-far (on current-word, project-wide)" })
