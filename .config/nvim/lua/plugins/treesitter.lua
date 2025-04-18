return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {"vim", "vimdoc", "java", "lua", "luadoc", "markdown", "javascript" },
			ignore_install = { 'help' },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
		vim.keymap.set('n', '<leader>ft', ':Neotree toggle=true<CR>')
	end
}
