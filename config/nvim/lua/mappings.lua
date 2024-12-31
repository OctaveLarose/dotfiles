require "nvchad.mappings"

local map = vim.keymap.set

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
map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

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
