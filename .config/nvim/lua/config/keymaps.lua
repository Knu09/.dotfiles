local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Icnrement / decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Buffer
keymap.set("n", "<tab>", ":bnext<Return>", opts)
keymap.set("n", "<s-tab>", ":bprev<Return>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<S-h>", ":tabnext<Return>", opts)
keymap.set("n", "<S-l>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Diagnostics

keymap.set("n", "<leader>r", function()
  require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
  require("craftzdog.lsp").toggleInlayHints()
end)

vim.api.nvim_create_user_command("ToggleAutoformat", function()
  require("craftzdog.lsp").toggleAutoformat()
end, {})
