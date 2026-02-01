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
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({})
                --[[ local lsp = vim.lsp
                local lua_config = lsp.config("lua_ls", {
                    --name = "lua_ls",
                    cmd = { "lua-language-server" },
                    filetypes = { 'lua' },
                    --root_markers = { ".git", ".editorconfig" },
                    root_dir = vim.fs.dirname(vim.fs.find({ ".git", ".editorconfig" }, { upward = true })[1]),
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                        },
                     },
                })
                --vim.lsp.enable("lua_ls")
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "lua",
                    callback = function(args)
                        -- this ensures we enable it after the buffer has the correct filetype
                        vim.lsp.enable("lua_ls", { bufnr = args.buf })
                    end,
                }) ]]--
			end
		}

	}
