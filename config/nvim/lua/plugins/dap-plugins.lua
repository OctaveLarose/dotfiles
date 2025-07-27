return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- "jay-babu/mason-nvim-dap.nvim",
      "mrcjkb/rustaceanvim"
    },
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
      vim.keymap.set("n", "<F12>", dap.restart)

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

      --
      -- ------ nvim dap rr stuff
      -- -- local cpptools_extension_path = vim.fn.stdpath("data") .. "/mason" .. "/packages" .. "/cpptools" .. "/extension"
      -- -- local cpptools_path = cpptools_extension_path .. "/debugAdapters/bin/OpenDebugAD7"
      -- local cpptools_path =
      -- "/home/octavel/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
      --
      -- dap.adapters.cppdbg = {
      --   id = "cppdbg",
      --   type = "executable",
      --   command = cpptools_path,
      -- }
      --
      -- local rr_dap = require("nvim-dap-rr")
      -- rr_dap.setup({
      --   mappings = {
      --     step_over = "<F1>",
      --     step_into = "<F2>",
      --     step_out = "<F4>",
      --     continue = "<F5>",
      --
      --     reverse_continue = "<F6>",
      --     -- reverse_continue = "<F19>",    -- <S-F7>
      --     reverse_step_over = "<F20>",   -- <S-F8>
      --     reverse_step_out = "<F21>",    -- <S-F9>
      --     reverse_step_into = "<F22>",   -- <S-F10>
      --     -- instruction level stepping
      --     step_over_i = "<F32>",         -- <C-F8>
      --     step_out_i = "<F33>",          -- <C-F8>
      --     step_into_i = "<F34>",         -- <C-F8>
      --     reverse_step_over_i = "<F44>", -- <SC-F8>
      --     reverse_step_out_i = "<F45>",  -- <SC-F9>
      --     reverse_step_into_i = "<F46>", -- <SC-F10>
      --   }
      -- })

      -- require('mason-nvim-dap').setup {
      --   -- Makes a best effort to setup the various debuggers with
      --   -- reasonable debug configurations
      --   automatic_installation = true,
      --
      --   -- You can provide additional configuration to the handlers,
      --   -- see mason-nvim-dap README for more information
      --   handlers = {},
      --
      --   ensure_installed = {}
      -- }
      ------------------------

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

      -- dap.configurations.cpp = { rr_dap.get_config() }
      -- dap.configurations.rust = { rr_dap.get_rust_config() }

      -- is uncaught needed? does this even work? not sure....
      dap.listeners.after.event_initialized["dap_exception_breakpoint"] = function()
        dap.set_exception_breakpoints({ "cpp_throw", "cpp_catch", "uncaught" })
      end

      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dapui.open()
      --   dap.set_exception_breakpoints("default")
      -- end

      -- dap.adapters.rust = vim.g.rustaceanvim.dap.adapter

      -- dap.defaults.rust.exception_breakpoints = { 'cpp_throw, cpp_catch' }
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      require("dapui").setup()
      ---@diagnostic disable: missing-fields
      require("nvim-dap-virtual-text").setup({})
    end,
  },

  -- { "jonboh/nvim-dap-rr", dependencies = { "nvim-dap", "telescope.nvim" } },
  { "jonboh/nvim-dap-rr", dependencies = { "nvim-dap" } },

  -- to have persistent breakpoints (in theory)
  -- {
  --   'daic0r/dap-helper.nvim',
  --   dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
  --   config = function()
  --     require("dap-helper").setup()
  --   end
  -- },
}
