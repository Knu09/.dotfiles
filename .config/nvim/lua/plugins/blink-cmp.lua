return {
  "saghen/blink.cmp",

  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer", "cmdline" },

      per_filetype = { sql = { "dadbod" } },
      providers = {
        dadbod = { module = "vim_dadbod_completion.blink" },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    keymap = {
      preset = "default",
      ["<C-e>"] = { "cancel" },

      -- ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      -- ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
    windows = {
      autocomplete = {
        border = "single",
      },
      documentation = {
        border = "single",
      },
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 400,
      },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            kind_icon = {
              text = function(ctx)
                local lspkind = require("lspkind")
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = lspkind.symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,

              -- Optionally, use the highlight groups from nvim-web-devicons
              -- You can also add the same function for `kind.highlight` if you want to
              -- keep the highlight groups in sync with the icons.
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },

  opts_extend = { "sources.default" },
}
