return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", enabled = false, opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    local util = require("lspconfig.util")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", builtin.lsp_references, opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
        -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", builtin.lsp_implementations, opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", builtin.lsp_type_definitions, opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", function()
          builtin.diagnostics({ bufnr = 0 })
        end, opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- setup mason
    require("mason").setup()

    -- setup each lsp manually (with custom settings)
    local servers = {
      html = {
        filetypes = { "html", "templ" },
      },
      emmet_ls = {
        filetypes = { "html", "templ", "astro", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        settings = {
          emmet = {
            includelanguages = { templ = "html" },
          },
        },
      },
      tsserver = {
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
      },
      eslint = {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentformattingprovider = true
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      },
      gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            useplaceholders = true,
            analyses = { unusedparams = true },
          },
        },
      },
      tailwindcss = {
        filetypes = {
          "templ",
          "html",
          "css",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "svelte",
        },
        root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "postcss.config.js"),
        settings = {
          tailwindcss = {
            includelanguages = { templ = "html" },
          },
        },
      },
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              ruff = { enabled = true },
              black = { enabled = true },
            },
          },
        },
      },
      intelephense = {
        settings = {
          intelephense = {
            files = { maxsize = 5000000 },
          },
        },
      },
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end
  end,
}
