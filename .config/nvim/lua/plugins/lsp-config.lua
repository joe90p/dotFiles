return
	{
		{
			"williamboman/mason.nvim",
			config = function ()
				require("mason").setup()
			end
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function ()
				require("mason-lspconfig").setup({
					ensure_installed = { "lua_ls", "jdtls" }
				}
				)
			end
		},
		{
			"neovim/nvim-lspconfig",
			config = function ()
				vim.lsp.config('lua_ls', {
					cmd = { "lua-language-server" },
					filetypes = { 'lua' },
					root_markers = { ".git", ".editorconfig" },
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				})
				vim.lsp.enable('lua_ls')
			end
		}

	}
