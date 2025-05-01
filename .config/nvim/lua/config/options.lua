-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.wo.number = true
vim.o.relativenumber = true
vim.o.linebreak = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.scrolloff = 10
vim.o.wrap = true
vim.o.breakindent = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
