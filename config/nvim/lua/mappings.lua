local map = vim.keymap.set


map({ "n", "i" }, "<C-q>", "<cmd>:q<CR>", { desc = "quit" })
map({ "i" }, "jk", "<ESC>", { desc = "exit insert mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><ESC>", { desc = "Ctrl+S save" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from clipboard" })
map({ "n", "v" }, "<leader>c", '"+c', { desc = "cut to system clipboard" })

-- a lot of these are from nvchad originally:
------------------------------

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Comment
map("n", "<leader>/", "gccj", { desc = "comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
map("n", "yc", "yygccp", { desc = "Copy line and comment it", remap = true })

-- tree
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "neotree toggle window" })
map("n", "<leader>e", "<cmd>Neotree reveal<CR>", { desc = "neotree focus window" })

-- LSP stuff. Previously relied on Client::on_attach to also set "buffer = bufnr", but I don't think I care much.
local function lsp_opts(desc)
  return { desc = "LSP " .. desc }
end

map("n", "gD", vim.lsp.buf.declaration, lsp_opts "Go to declaration")
map("n", "gd", vim.lsp.buf.definition, lsp_opts "Go to definition")
map("n", "gi", vim.lsp.buf.implementation, lsp_opts "Go to implementation")
map("n", "<leader>D", vim.lsp.buf.type_definition, lsp_opts "Go to type definition")
map("n", "gr", "<cmd>FzfLua lsp_references<CR>", lsp_opts "Show references")
map("n", "gt", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", lsp_opts "Show live workspace symbols")

map("n", "<leader>ra", function() require("live-rename").rename({ insert = true }) end, lsp_opts "live-rename")

map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Go to next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Go to prev diagnostic" })
map("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Diagnostics in quickfix list" })

-- map("n", "<leader>sh", vim.lsp.buf.signature_help, lsp_opts "Show signature help")
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, lsp_opts "Add workspace folder")
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, lsp_opts "Remove workspace folder")

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lsp_opts "Code action")
map("n", "<space>h", vim.lsp.buf.hover,
  { noremap = true, silent = true, desc = "Hover action" }
)

------------------------------

-- tab/barbar stuff
map("n", "<tab>", "<cmd>BufferNext<cr>", { desc = "buffer goto next" })
map("n", "<S-tab>", "<cmd>BufferPrevious<cr>", { desc = "buffer goto prev" })
map("n", "<A-c>", "<cmd>BufferClose<cr>", { desc = "buffer close" })
map("n", "<A-q>", "<cmd>BufferCloseAllButCurrent<cr>", { desc = "buffer close all but current" })
map("n", "<A-p>", "<cmd>BufferPin<cr>", { desc = "pin current buffer" })

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", "<cmd>BufferGoto " .. i .. "<CR>", { desc = "buffer goto " .. i })
end
vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<CR>", { desc = "buffer goto last" })

------------------------------

-- fzf-lua, general commands
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "fzf-lua find files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<cr>", { desc = "fzf-lua live grep" })
map("n", "<leader>fe", "<cmd>FzfLua oldfiles<cr>", { desc = "fzf-lua old files" })            -- previously fo
map("n", "<leader>fr", "<cmd>FzfLua tags_live_grep<cr>", { desc = "fzf-lua tags live grep" }) -- previously ft
map("n", "<leader>fm", "<cmd>FzfLua marks<cr>", { desc = "fzf-lua marks" })

map("n", "<leader>rr", ":make b <cr>", { silent = true, desc = "Make build" })

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

-- treesitter expansion selection mappings. example from the doc, but gives a missing-fields warning still
---@diagnostic disable: missing-fields
require('nvim-treesitter.configs').setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-w>",
      scope_incremental = "<TAB>",
      node_incremental = "<C-w>",
      node_decremental = "<bs>",
    },
  },
}

map("n", "<C-L><C-L>", "<cmd>:set invrelativenumber<CR>", { desc = "Toggle relative line numbers" })

-- centered scrolling with C-u/C-d
-- map("n", "<C-u>", function() require("cinnamon").scroll("<C-U>zz") end)
-- map("n", "<C-d>", function() require("cinnamon").scroll("<C-d>zz") end)


-- snippets stuff
local ls = require("luasnip")
map({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

map({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })


map({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- auto reloads snippets supposedly
map("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
