return {
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig/configs")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- mason-lspconfig
      local gopls = require("plugins.lsp.gopls")
      local htmx = require("plugins.lsp.htmx")
      local html = require("plugins.lsp.html")
      local emmet = require("plugins.lsp.emmet")
      -- lspconfig

      -- add cmp_nvim_lsp capabilities settings to lspconfig
      -- this should be executed before you configure any language server
      -- local lspconfig_defaults = lspconfig.util.default_config
      -- lspconfig_defaults.capabilities =
      --   vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Setup lsp using lspconfig
      lspconfig.lua_ls.setup({})
      lspconfig.clangd.setup({})

      -- Setup lsp using mason-lspconfig
      require("mason").setup({})
      require("mason-lspconfig").setup({
        automatic_installation = false,
        ensure_installed = {
          "cssls",
          "ts_ls",
          "emmet-ls",
          "html",
          "htmx",
          "eslint",
          "templ",
          "tailwindcss",
          "gopls",
          "pyright",
          "bashls",
          "tinymist",
          "marksman",
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
            lspconfig.emmet_ls.setup({
              capabilities = capabilities,
              filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
              init_options = {
                html = {
                  options = {
                    ["bem.enabled"] = true,
                  },
                },
                includeLanguages = {
                  templ = "html",
                },
              },
              root_dir = util.root_pattern(".git", vim.fn.getcwd()),
            })
          end,
          gopls = function()
            lspconfig.gopls.setup(gopls)
          end,
          htmx = function()
            lspconfig.htmx.setup(htmx)
          end,
        },
      })
    end,
  },
}
