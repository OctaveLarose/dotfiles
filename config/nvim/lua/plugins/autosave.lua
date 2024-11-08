return {
  "okuuva/auto-save.nvim",
  version = '^1.0.0',                       -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
  cmd = "ASToggle",                         -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {},
  condition = function(buf)
    local fn = vim.fn
    local filepath = fn.expand('%:p')

    if not filepath:match('^/home/octavel/.config/nvim') then
      return true
    end
    return false
  end
}
