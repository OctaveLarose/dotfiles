return {
  { "meznaric/key-analyzer.nvim", opts = {} },

  {
    "nvzone/typr",
    cmd = "TyprStats",
    dependencies = "nvzone/volt",
    opts = {},
  },

  {
    "sphamba/smear-cursor.nvim",
  },

  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    opts = {
      lang = "python3",
      -- image_support = true -- using 3rd/image
    },
  }
}
