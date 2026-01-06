return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- "jay-babu/mason-nvim-dap.nvim",
      "mrcjkb/rustaceanvim",
      "nvim-neotest/nvim-nio", -- needed by dapui?
      "theHamsta/nvim-dap-virtual-text"
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

      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb",
      }

      -- require('mason-nvim-dap').setup {
      --   -- Makes a best effort to setup the various debuggers with
      --   -- reasonable debug configurations
      --   automatic_installation = true,
      --
      --   -- You can provide additional configuration to the handlers,
      --   -- see mason-nvim-dap README for more information
      --   handlers = {},
      --
      --   ensure_installed = { "codelldb" }
      -- }

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

      ---@diagnostic disable: missing-fields
      dapui.setup({
        layouts = { {
          elements = {
            {
              id = "scopes",
              size = 0.45
            },
            {
              id = "stacks",
              size = 0.25
            },
            {
              id = "breakpoints",
              size = 0.10
            },
            -- {
            --   id = "watches",
            --   size = 0.25
            -- }
          },
          position = "left",
          size = 60
        }, {
          elements = { {
            id = "console",
            size = 0.65
          }, {
            id = "repl",
            size = 0.35
          } },
          position = "bottom",
          size = 10
        } }
      })
      ---@diagnostic disable: missing-parameter
      require("nvim-dap-virtual-text").setup()

      dap.listeners.after.event_initialized["dap_exception_breakpoint"] = function()
        dap.set_exception_breakpoints({ "cpp_throw", "cpp_catch", "uncaught", "rust_panic" })
        -- I find that for some reason, rust_panic isn't a default in Rust at least? So I shouldn't use "default", I guess...
        -- dap.set_exception_breakpoints("default")
      end

      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dapui.open()
      --   dap.set_exception_breakpoints("default")
      -- end

      -- dap.adapters.rust = vim.g.rustaceanvim.dap.adapter

      -- dap.defaults.rust.exception_breakpoints = { 'cpp_throw, cpp_catch' }
    end,
  },

  -- { "jonboh/nvim-dap-rr", dependencies = { "nvim-dap" } },

  -- to have persistent breakpoints (in theory)
  -- {
  --   'daic0r/dap-helper.nvim',
  --   dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
  --   config = function()
  --     require("dap-helper").setup()
  --   end
  -- },
}
