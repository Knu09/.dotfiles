return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    local util = require("lspconfig.util")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup lsp using lspconfig
    lspconfig.lua_ls.setup({})
    lspconfig.clangd.setup({})

    -- Setup lsp using mason-lspconfig
    require("mason").setup({})

    mason_lspconfig.setup_handlers({
      -- default handler for installed server
      function(server_name)
        lspconfig[server_name].setup({})
      end,
      lua_ls = function() end,
      ["html"] = function()
        lspconfig["html"].setup({
          capabilities = capabilities,
          filetypes = { "html", "templ" },
        })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
          settings = {
            emmet = {
              includeLanguages = {
                templ = "html",
              },
            },
          },
        })
      end,
      ["gopls"] = function()
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
          root_dir = util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        })
      end,
      ["htmx"] = function()
        lspconfig["htmx"].setup({
          capabilities = capabilities,
          filetypes = { "html", "templ" },
        })
      end,
    })
  end,
}
