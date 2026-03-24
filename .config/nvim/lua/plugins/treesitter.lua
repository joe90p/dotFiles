return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function ()
		local parsers = { "vim", "vimdoc", "java", "lua", "luadoc", "markdown", "javascript" }
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		vim.keymap.set('n', '<leader>ft', ':Neotree toggle=true<CR>')
	end
}
