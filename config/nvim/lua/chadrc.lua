-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",

  statusline = {
    enabled = true,
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },

  hl_override = {
    NvimTreeGitModifiedIcon = { "o" },
    NvimTreeGitDirtyIcon = { "o" }
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
  },
}

return M
