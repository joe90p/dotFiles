-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

-- Find the root directory (where pom.xml lives)
local rootDir = require('jdtls.setup').find_root({ 'pom.xml' })

-- Derive a project name from the last folder of the root
local projectName = vim.fn.fnamemodify(rootDir, ':t')

local debug_plugins = vim.fn.glob(
  "~/.local/share/java-debug/com.microsoft.java.debug.plugin-*.jar", 
  true
)
local bundles = { unpack(vim.split(debug_plugins, "\n")) }


local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		'java21', -- or '/path/to/java21_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		-- 💀
		'-jar',
		'/home/phil/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar',
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version


		-- 💀
		'-configuration', '/home/phil/.local/share/nvim/mason/packages/jdtls/config_linux',
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.


		-- 💀
		-- See `data directory configuration` section in the README
		--'-data', '/path/to/unique/per/project/workspace/folder'
		'-data', vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. projectName
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	--
	-- vim.fs.root requires Neovim 0.10.
	-- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
	--root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
	root_dir = require('jdtls.setup').find_root({ 'pom.xml' }),
	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			trace = {
				server = "verbose"
			}
		}
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles
	},
	on_attach = function()
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
		vim.keymap.set('n', 'zx', vim.lsp.buf.references)
		vim.keymap.set('n', '<leader>fk', vim.lsp.buf.format)
		vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
        local dap = require("dap")
        dap.configurations.java = {
            {
                type = "java",
                request = "attach",
                name = "PHIL TEST",
                hostName = "localhost",
                port = "8787"  -- change this if needed
            }
        }
        local dapui = require("dapui")
        dapui.setup()
        local opts = { silent = true, buffer = bufnr }
        vim.keymap.set("n", "<F5>", function() dap.continue() end, opts)
        vim.keymap.set("n", "<F10>", function() dap.step_over() end, opts)
        vim.keymap.set("n", "<F11>", function() dap.step_into() end, opts)
        vim.keymap.set("n", "<F12>", function() dap.step_out() end, opts)
        vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
        end
	end
}
require('jdtls').setup_dap({
  hotcodereplace = "auto" -- lets you change code without restarting
})
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
