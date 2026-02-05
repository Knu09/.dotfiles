return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      local builtin = require("telescope.builtin")

      -- Patch: bypass broken dartls capability detection
      local orig_lsp_definitions = builtin.lsp_definitions
      builtin.lsp_definitions = function(opts)
        -- If native LSP works, use it directly
        vim.lsp.buf.definition()
      end

      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to Definition (Dart-safe)" })

      telescope.load_extension("ui-select")
    end,
  },
}
