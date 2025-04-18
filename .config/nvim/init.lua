local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazyPath)
--vim.opt.clipboard = unnamedplus
vim.cmd("set mouse=")
vim.cmd("set number relativenumber")
require("lazy").setup("plugins")
--vim.keymap.set('n', 'gd', 
