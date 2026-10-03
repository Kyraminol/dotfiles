return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		build = vim.fn.has("win32") ~= 0
				and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		---@module 'avante'
		---@type avante.Config
		opts = {
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			---@type Provider
			provider = "siegmeyer",
			---@alias Mode "agentic" | "legacy"
			---@type Mode
			mode = "agentic",
			rocks = {
				enabled = false,
			},
			providers = {
				siegmeyer = {
					__inherited_from = "openai",
					endpoint = vim.env.LLM_SIEGMEYER_URL,
					timeout = 30000,
					api_key_name = "LLM_SIEGMEYER_KEY",
					model = "siegmeyer",
				},
			},
			dual_boost = {
				enabled = false,
			},
			behaviour = {
				auto_suggestions = false,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
				minimize_diff = true,
				enable_token_counting = true,
				auto_add_current_file = true,
				auto_approve_tool_permissions = true,
				---@type "popup" | "inline_buttons"
				confirmation_ui_style = "inline_buttons",
				---@type boolean
				acp_follow_agent_locations = true,
			},
			prompt_logger = {
				enabled = true,
				log_dir = vim.fn.stdpath("cache") .. "/avante_prompts",
				fortune_cookie_on_success = false,
				next_prompt = {
					normal = "<C-n>",
					insert = "<C-n>",
				},
				prev_prompt = {
					normal = "<C-p>",
					insert = "<C-p>",
				},
			},
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				cancel = {
					normal = { "<C-c>", "<Esc>", "q" },
					insert = { "<C-c>" },
				},
				sidebar = {
					apply_all = "A",
					apply_cursor = "a",
					retry_user_request = "r",
					edit_user_request = "e",
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
					remove_file = "d",
					add_file = "@",
					close = { "<Esc>", "q" },
					close_from_input = nil,
				},
			},
			selection = {
				enabled = true,
				hint_display = "delayed",
			},
			windows = {
				---@type "right" | "left" | "top" | "bottom"
				position = "right",
				wrap = true,
				width = 30,
				sidebar_header = {
					enabled = true,
					align = "center",
					rounded = true,
				},
				spinner = {
					editing = {
						"⡀",
						"⠄",
						"⠂",
						"⠁",
						"⠈",
						"⠐",
						"⠠",
						"⢀",
						"⣀",
						"⢄",
						"⢂",
						"⢁",
						"⢈",
						"⢐",
						"⢠",
						"⣠",
						"⢤",
						"⢢",
						"⢡",
						"⢨",
						"⢰",
						"⣰",
						"⢴",
						"⢲",
						"⢱",
						"⢸",
						"⣸",
						"⢼",
						"⢺",
						"⢹",
						"⣹",
						"⢽",
						"⢻",
						"⣻",
						"⢿",
						"⣿",
					},
					generating = { "·", "✢", "✳", "∗", "✻", "✽" },
					thinking = { "🤯", "🙄" },
				},
				input = {
					prefix = "> ",
					height = 8,
				},
				edit = {
					border = "rounded",
					start_insert = true,
				},
				ask = {
					floating = false,
					start_insert = true,
					border = "rounded",
					---@type "ours" | "theirs"
					focus_on_apply = "ours",
				},
			},
			highlights = {
				---@type AvanteConflictHighlights
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
			},
			--- @class AvanteConflictUserConfig
			diff = {
				autojump = true,
				---@type string | fun(): any
				list_opener = "copen",
				override_timeoutlen = 500,
			},
			suggestion = {
				debounce = 600,
				throttle = 600,
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{ "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
			"nvim-telescope/telescope.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"rauls-kjarners/omp.nvim",
		event = "VeryLazy",
		dependencies = {
			"folke/snacks.nvim",
		},
		config = function()
			require("omp").setup()
			vim.keymap.set("n", "<leader>lp", function()
				Snacks.terminal.toggle("omp", {
					win = {
						position = "right",
						width = 0.4,
					},
				})
			end, { desc = "Toggle omp" })
		end,
	},
	{
		"sudo-tee/opencode.nvim",
		dependencies = {
			"MeanderingProgrammer/render-markdown.nvim",
			"folke/snacks.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("opencode").setup({})
		end,
	},
}
