return {
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    -- Unmap conflicting keys first
    vim.keymap.set({ "n", "x", "o" }, "s", "<Nop>", { silent = true })
    vim.keymap.set("n", "S", "<Nop>", { silent = true })
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
