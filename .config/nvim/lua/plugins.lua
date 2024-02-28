return {
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  { "folke/which-key.nvim", opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "yioneko/nvim-yati",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
