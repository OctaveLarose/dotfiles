return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- jump = {
      --   autojump = true,
      -- }
    },
    -- stylua: ignore
    keys = {
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "s", mode = { "n", "x" },      function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    }
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      file_ignore_patterns = { "tags" },
      files = {
        fzf_opts = {
          ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-files-history',
        },
      },
      grep = {
        fzf_opts = {
          ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-grep-history',
        },
      },
      keymap = {
        fzf = {
          true,
          ["ctrl-q"] = "select-all+accept", -- select all items and add them to the quickfix list
          ["ctrl-j"] = "previous-history",  -- previously ["left"]
          ["ctrl-k"] = "next-history",      -- previously ["right"]
        },
      }
    }
  },

  {
    'echasnovski/mini.ai',
    version = '*',
    config = function()
      require("mini.ai").setup()
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  {
    "ludovicchabant/vim-gutentags"
  }
}
