return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      jump = {
        autojump = true,
      }
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    }
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
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
          -- Use <c-q> to select all items and add them to the quickfix list
          ["ctrl-q"] = "select-all+accept",
          ["left"] = "previous-history",
          ["right"] = "next-history",
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
  }
}
