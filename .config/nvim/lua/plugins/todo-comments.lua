return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
  },
  event = "VeryLazy", -- optional: defer loading
}
