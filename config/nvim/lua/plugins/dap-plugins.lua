return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Debugger toggle breakpoint" })
      vim.keymap.set("n", "<F1>", dap.step_over)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_back)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<F6>", dap.up)
      vim.keymap.set("n", "<F7>", dap.down)
      vim.keymap.set("n", "<F10>", dapui.close)
      vim.keymap.set("n", "<F13>", dap.restart)

      vim.keymap.set("n", "<Leader>de", dap.terminate, { desc = "Debugger reset" })
      vim.keymap.set("n", "<Leader>dr", dap.run_last, { desc = "Debugger run last" })

      vim.keymap.set(
        "n",
        "<Leader>dd",
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        { desc = "Debugger set conditional breakpoint" }
      )

      vim.keymap.set(
        "n",
        "<Leader>dv",
        "<cmd>lua require'dapui'.eval(vim.fn.input('Evaluate expression: '))<CR>",
        { desc = "Debugger evaluate expression" }
      )

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   dapui.close()
      -- end
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- to have persistent breakpoints (in theory)
  -- {
  --   'daic0r/dap-helper.nvim',
  --   dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
  --   config = function()
  --     require("dap-helper").setup()
  --   end
  -- },
}
