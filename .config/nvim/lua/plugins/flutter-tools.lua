return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        widget_guides = { enabled = true },
        closing_tags = { enabled = true },
        lsp = { settings = { showTodos = true } },
      })
    end,
  },
}
