return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })

      vim.keymap.set({ "n", "t" }, "<C-\\>", function()
        require("toggleterm").toggle()
      end, { desc = "Toggle Terminal" })
    end,
  },
}
