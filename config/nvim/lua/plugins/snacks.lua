return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "/opt/shell-color-scripts/colorscript.sh -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      indent = {
        enabled = true,
        duration = {
          step = 10,  -- (ms - default is 20)
          total = 200 -- max duration - default 500
        },
        scope = {
          hl = "@lsp.type.keyword"
        }
      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 5000,
      },
      quickfile = { enabled = true },
      -- for now i prefer neoscroll for how it handles horizontal cursor adjustment
      -- scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      ---@type fun(opts?: snacks.lazygit.Config): snacks.win
      { "<leader>gi", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- TODO - try some of these!

          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          -- "<leader>uc")
          -- Snacks.toggle.treesitter():map("<leader>uT")
          -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          -- Snacks.toggle.inlay_hints():map("<leader>uh")
          -- Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
}
