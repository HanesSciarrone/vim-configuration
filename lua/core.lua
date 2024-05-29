vim.opt.number = true                       -- Print the line number in front of each line
vim.opt.numberwidth = 1                     -- Number of columns used for the line number
vim.opt.clipboard = "unnamed"               -- Use the clipboard as the unnamed register
vim.opt.clipboard = "unnamedplus"           -- Use the clipboard as the unnamed register
vim.opt.mouse = "a"                         -- Enable the use of mouse clicks
vim.opt.tabstop = 4                         -- Number of spaces that <Tab> in file uses
vim.opt.shiftwidth = 4                      -- Number of spaces to use for (auto)indent step
vim.opt.expandtab = true                    -- Use spaces when <Tab> is inserted
vim.opt.laststatus = 2                      -- Tells when last window has status lines
vim.opt.showmode = false                    -- Not show the neovim mode
vim.opt.showmatch = true                    -- Briefly jump to matching bracket if insert one
vim.opt.guifont = "Hack Nerd Font 12"       -- GUI: Name(s) of font(s) to be used
vim.opt.syntax = "ON"                       -- Syntax to be loaded for current buffer

-- ====================================== Shorcut key ======================================
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w" , "<cmd>write<CR>")
vim.keymap.set("n", "<leader>q" , "<cmd>quit<CR>")
vim.keymap.set("n", "<leader>wq", ":wq<CR>")
