local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
print(lazyPath)
if not vim.loop.fs_stat(lazyPath) then
	print("no lazy path")
	vim.fn.system({ "git",
	"clone",
	"--filter=blob:none",
	"--branch=stable",
	"https://github.com/folke/lazy.nvim.git",
	lazyPath
})
	print("got here")
else
	print("there is a lazy path")
end

vim.opt.rtp:prepend(lazyPath)
--vim.opt.clipboard = unnamedplus
vim.cmd("set mouse=")
vim.cmd("set number relativenumber")
vim.opt.tabstop = 4      -- how many spaces a literal <Tab> displays as
vim.opt.shiftwidth = 4   -- how many spaces to use for auto-indent
vim.opt.softtabstop = 4  -- how many spaces <Tab> inserts in insert mode
vim.opt.expandtab = true -- insert spaces instead of literal <Tab> characters

require("lazy").setup("plugins")


--vim.keymap.set('n', 'gd', 
