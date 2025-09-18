return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dap_utils = require("dap.utils")
			local dapui = require("dapui")

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

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			local map = function(keys, func, desc)
				if desc then
					desc = "[D]ebugger: " .. desc
				end
				if keys then
					keys = "<leader>d" .. keys
				end
				vim.keymap.set("n", keys, func, { desc = desc })
			end

			map("c", dap.continue, "[C]ontinue")
			map("b", dap.toggle_breakpoint, "Toggle [B]reakpoint")
			map("i", dap.step_into, "Step [I]nto")
			map("O", dap.step_out, "Step [O]ut")
			map("o", dap.step_over, "Step Over")
			map("C", function()
				require("dap").run_to_cursor()
			end, "Run to [C]ursor")
			map("g", function()
				require("dap").goto_()
			end, "[G]o to line (no execute)")
			map("b", dap.toggle_breakpoint, "Toggle [B]reakpoint")
			map("B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, "Set [B]reakpoint")
			map("j", dap.down, "Down")
			map("k", dap.up, "Up")
			map("l", dap.run_last, "Run [L]ast")
			map("p", dap.pause, "Pause")
			map("r", function()
				dap.repl.toggle()
			end, "Toggle REPL")
			map("s", dap.session, "Session")
			map("t", dap.terminate, "Terminate")
			map("w", function()
				require("dap.ui.widgets").hover()
			end, "Widgets")

			map("u", function()
				dapui.toggle({
					-- Always open the nvim dap ui in the default sizes
					reset = true,
				})
			end, "Toggle [U]I")
			map("e", function()
				dapui.eval()
			end, "Eval")
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
}
