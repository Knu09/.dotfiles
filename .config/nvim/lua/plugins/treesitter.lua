return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "c",
          "rust",
          "go",
          "lua",
          "vim",
          "css",
          "html",
          "javascript",
          "python",
          "scss",
          "tsx",
          "typescript",
          "vue",
          "markdown",
          "markdown_inline",
          "sql",
          "hyprlang",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        auto_install = true,
        -- List of parsers to ignore installing (for "all")
        ignore_install = { "latex" },
        indent = { enable = true },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        autotag = {
          enable = true,
        },
        vim.filetype.add({
          pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        }),
        vim.filetype.add({ extension = { templ = "templ" } }),
      })
    end,
  },
}
