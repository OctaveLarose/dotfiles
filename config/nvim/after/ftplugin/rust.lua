local bufnr = vim.api.nvim_get_current_buf()

--- Rusteaceanvim stuff

vim.keymap.set("n", "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction')
    -- or vim.lsp.buf.codeAction() for no rust-analyzer grouping
  end,
  { silent = true, buffer = bufnr, desc = "RustLsp code action" }
)

vim.keymap.set("n", "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'hover', 'actions' })
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set("n", "<Leader>dt",
  function()
    vim.cmd('RustLsp testables')
  end,
  { desc = "Debugger testables" }
)

local dap = require("dap")

dap.adapters.rust = vim.g.rustaceanvim.dap.adapter -- is that really needed?

-- should really be just in the som-rs project, but fine as is for now as it's my only active rust project
dap.configurations.rust = {
  {
    name = "run-benchmark-ast",
    type = "rust",
    request = "launch",
    program = function()
      return vim.fn.getcwd() .. "/target/debug/som-interpreter-ast"
    end,
    args = function()
      --- this code likely sucks but I'm bad at lua
      -- local main_co = coroutine.running()
      -- local result
      --
      -- vim.ui.input({ prompt = "Benchmark: " }, function(input)
      --   result = benchmark_args_fn(input)
      --   coroutine.resume(main_co)
      -- end)
      --
      -- coroutine.yield() -- Pause execution until resumed
      -- return result
      local main_co = coroutine.running()
      vim.ui.input({ prompt = "Benchmark: " }, function(input)
        coroutine.resume(main_co, benchmark_args_fn(input))
      end)
      return coroutine.yield()
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "run-benchmark-bc",
    type = "rust",
    request = "launch",
    program = function()
      return vim.fn.getcwd() .. "/target/debug/som-interpreter-bc"
    end,
    args = function()
      local main_co = coroutine.running()
      vim.ui.input({ prompt = "Benchmark: " }, function(input)
        coroutine.resume(main_co, benchmark_args_fn(input))
      end)
      return coroutine.yield()
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "run-last-ast-benchmark",
    type = "rust",
    request = "launch",
    program = function()
      return vim.fn.getcwd() .. "/target/debug/som-interpreter-ast"
    end,
    args = function()
      return benchmark_args_fn(vim.g.last_benchmark_ran)
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "run-last-bc-benchmark",
    type = "rust",
    request = "launch",
    program = function()
      -- vim.fn.system("cargo build -p som-interpreter-bc");
      return vim.fn.getcwd() .. "/target/debug/som-interpreter-bc"
    end,
    args = function()
      return benchmark_args_fn(vim.g.last_benchmark_ran)
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "ast-with-args",
    type = "rust",
    request = "launch",
    program = function()
      return vim.fn.getcwd() .. "/target/debug/som-interpreter-ast"
    end,
    args = function()
      local main_co = coroutine.running()
      vim.ui.input({ prompt = "Benchmark name and number of iterations: " }, function(input)
        coroutine.resume(main_co, benchmark_args_fn_with_args(input))
      end)
      return coroutine.yield()
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

function benchmark_args_fn(benchmark_name)
  local classpath_items = {
    "Smalltalk",
    "Examples/Benchmarks",
    "Examples/Benchmarks/LanguageFeatures",
    "Examples/Benchmarks/Json",
    "Examples/Benchmarks/Richards",
    "Examples/Benchmarks/DeltaBlue"
  }

  local classpath = {}
  for _, item in ipairs(classpath_items) do
    table.insert(classpath, { "-c", "core-lib/" .. item })
  end

  table.insert(classpath, { "--", "core-lib/Examples/Benchmarks/BenchmarkHarness.som", benchmark_name, "1", "7" })

  classpath = vim.tbl_flatten(classpath)

  vim.g.last_benchmark_ran = benchmark_name

  return vim.tbl_flatten(classpath)
end

function benchmark_args_fn_with_args(benchmark_name_and_iters)
  local classpath_items = {
    "Smalltalk",
    "Examples/Benchmarks",
    "Examples/Benchmarks/LanguageFeatures",
    "Examples/Benchmarks/Json",
    "Examples/Benchmarks/Richards",
    "Examples/Benchmarks/DeltaBlue"
  }

  local classpath = {}
  for _, item in ipairs(classpath_items) do
    table.insert(classpath, { "-c", "core-lib/" .. item })
  end

  table.insert(classpath,
    { "--", "core-lib/Examples/Benchmarks/BenchmarkHarness.som", vim.split(benchmark_name_and_iters, " ") })

  classpath = vim.tbl_flatten(classpath)

  vim.g.last_benchmark_ran = benchmark_name

  return vim.tbl_flatten(classpath)
end

local rr_dap = require("nvim-dap-rr")
table.insert(dap.configurations.rust, rr_dap.get_rust_config(
  {
    name = "rr",
    type = "cppdbg",
    program = function()
      return vim.fn.getcwd() .. "/target/debug/som-interpreter-bc"
    end,
    args = function()
      -- local benchmark_name = vim.fn.input("Benchmark: ")
      -- return benchmark_args_fn(benchmark_name)
      return benchmark_args_fn("Richards")
    end,
    stopOnEntry = true
  }
))
