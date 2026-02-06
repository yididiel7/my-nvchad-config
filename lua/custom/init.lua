vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.expandtab = true
-- Sets the number of spaces a <Tab> in the text stands for
--	(local to buffer) 
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
--  Synchronizes the system 
--  with Neovim's .
vim.opt.clipboard = "unnamedplus"
-- number of screen lines to show around the cursor 
vim.opt.scrolloff = 999
vim.opt.cursorcolumn = true
vim.opt.termguicolors = true
-- Virtual editing means that the cursor can be positioned where there is
--	no actual character.
vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.cursorline = true

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd[[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
    augroup END
]]
