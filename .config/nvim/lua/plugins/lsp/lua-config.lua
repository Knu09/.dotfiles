return {
  -- LSP Support
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- mason-lspconfig
      local gopls = require("plugins.lsp.gopls")
      local htmx = require("plugins.lsp.htmx")
      local html = require("plugins.lsp.html")
      local emmet = require("plugins.lsp.emmet")
      local lspconfig_defaults = lspconfig.util.default_config

      lspconfig_defaults.capabilities =
        vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Setup lsp using mason-lspconfig
      require("mason-lspconfig").setup({
        automatic_installation = false,
        ensure_installed = {
          "lua-language-server",
          "css-lsp",
          "tsserver",
          "emmet-ls",
          "html-lsp",
          "htmx-lsp",
          "eslint-lsp",
          "templ",
          "tailwindcss-language-server",
          "gopls",
          "pyright",
          "jdtls",
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({})
          end,
          lua_ls = function() end,
          html = function()
            lspconfig.html.setup(html)
          end,
          emmet_ls = function()
            lspconfig.emmet_ls.setup(emmet)
          end,
          gopls = function()
            lspconfig.gopls.setup(gopls)
          end,
          htmx = function()
            lspconfig.htmx.setup(htmx)
          end,
        },
        require("mason-lspconfig").setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({ capabilities = capabilities })
          end,
        }),
      })
    end,
  },
}
