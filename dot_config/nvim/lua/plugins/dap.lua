return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dap_utils = require("dap.utils")

			dap.adapters = {
				["pwa-node"] = {
					type = "server",
					port = "${port}",
					host = "localhost",
					executable = {
						command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
						args = {
							"${port}",
						},
					},
				},
				["codelldb"] = {
					type = "server",
					port = "${port}",
					executable = {
						command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
						args = { "--port", "${port}" },
					},
				},
				["go"] = function(callback, conf)
					if conf.request == "attach" and (conf.mode == "remote" or conf.mode == "exec") then
						local port = conf.port
						callback({
							type = "server",
							port = assert(port, "`connect.port` is required"),
							host = conf.host or "127.0.0.1",
						})
					else
						callback({
							type = "server",
							port = "${port}",
							executable = {
								command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
								args = { "dap", "-l", "127.0.0.1:${port}" },
							},
						})
					end
				end,
			}

			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to process ID",
						processId = dap_utils.pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch & Debug Chrome",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
					{
						name = "----- ↓ launch.json configs ↓ -----",
						type = "",
						request = "launch",
					},
				}
			end

			dap.configurations.rust = {
				{
					type = "codelldb",
					request = "launch",
					name = "Launch file",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			}

			dap.configurations.go = {
				{
					type = "go",
					name = "Debug file",
					request = "launch",
					program = "${file}",
				},
				{
					type = "go",
					name = "[Docker] Attach to debug server",
					request = "attach",
					host = "127.0.0.1",
					port = "2345",
					mode = "remote",
					cwd = vim.fn.getcwd(),
					substitutePath = {
						{
							from = "/home/andu/go/src/github.com/docker/docker",
							to = "/go/src/github.com/docker/docker",
						},
					},
				},
				{
					type = "go",
					name = "Attach to debug server",
					request = "attach",
					processId = dap_utils.pick_process,
					mode = "local",
					cwd = vim.fn.getcwd(),
					custom = "foo",
				},
			}

			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "Error" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "WarningMsg" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DiffAdd", linehl = "CursorLine" })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
	},
	{
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"MironPascalCaseFan/debugmaster.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"jbyuki/one-small-step-for-vimkind",
		},
		config = function()
			local debugmaster = require("debugmaster")
			local dap = require("dap")

			debugmaster.plugins.osv_integration.enabled = true

			debugmaster.keys.add({
				key = "p",
				desc = "Toggle Exec Direction (RR)",
				action = (function()
					local dir = "forward"
					return function()
						local s = dap.session()
						if not s then
							return vim.notify("No active session", vim.log.levels.WARN)
						end
						dir = (dir == "forward" and "reverse" or "forward")
						s:evaluate("-exec set exec-direction " .. dir)
						vim.notify("Execution Direction: " .. dir:upper(), vim.log.levels.INFO)
					end
				end)(),
			})

			vim.keymap.set("n", "<leader>d", debugmaster.mode.toggle, { desc = "Toggle Debug Mode" })
			vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
		end,
	},
}
