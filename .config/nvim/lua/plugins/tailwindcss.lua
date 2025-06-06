return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = function(_, opts)
      local util = require("lspconfig.util")
      local root = util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "postcss.config.js")(vim.fn.getcwd())

      opts.user_default_options = opts.user_default_options or {}
      opts.user_default_options.tailwind = root ~= nil

      opts.filetypes = {
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
      }

      return opts
    end,
    lazy = true,
  },
}
