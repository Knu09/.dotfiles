local telescope = require("telescope")

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
      -- Telescope Flutter commands
      vim.keymap.set("n", "<leader>Ff", function()
        telescope.extensions.flutter.commands()
      end, { desc = "Flutter: Telescope Commands" })

      -- Direct Flutter commands
      vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterReload<CR>", { desc = "Flutter: Hot Reload" })
      vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRun<CR>", { desc = "Flutter: Hot Restart" })
      vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter: List Devices" })
      vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter: List Emulators" })
      vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterLogToggle<CR>", { desc = "Flutter: Toggle Dev Log" })
      vim.keymap.set("n", "<leader>Fc", "<cmd>FlutterLogClear<CR>", { desc = "Flutter: Clear Dev Log" })
    end,
  },
}
