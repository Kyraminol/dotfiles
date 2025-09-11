return {
	{
		"CWood-sdf/spaceport.nvim",
		lazy = false, -- load spaceport immediately
		config = function()
			local ascii_arts_table = {
				{
					ascii_art = {
						[[                                                     ]],
						[[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
						[[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
						[[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
						[[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
						[[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
						[[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
						[[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
						[[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
						[[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
						[[                                 ░                   ]],
						[[                                                     ]],
					},
					colorOpts = {
						fg = "#05ac00",
					},
				},
			}

			require("spaceport").setup({
				-- This prevents the same directory from being repeated multiple times in the recents section
				-- For example, I have replaceDirs set to { {"~/projects", "_" } } so that ~/projects is not repeated a ton
				-- Note every element is applied to the directory in order,
				--   so if you have { {"~/projects", "_"} } and you also want to replace
				--   ~/projects/foo with @, then you would need
				--   { {"~/projects/foo", "@"}, {"~/projects", "_"} }
				--   or { {"~/projects", "_"}, {"_/foo", "@"} }
				replaceDirs = {},

				-- turn /home/user/ into ~/ (also works on windows for C:\Users\user\)
				replaceHome = true,

				-- What to do when entering a directory, personally I use "Oil .", but Ex is preinstalled with neovim
				projectEntry = "bd",

				-- The farthest back in time that directories should be shown
				-- I personally use "yesterday" so that there aren't millions of directories on the screen.
				-- the possible values are: "pin", "today", "yesterday", "pastWeek", "pastMonth", and "later"
				lastViewTime = "today",

				-- The maximum number of directories to show in the recents section (0 means show all of them)
				maxRecentFiles = 0,

				-- The sections to show on the screen (see `Customization` for more info)
				sections = {
					"_global_remaps",
					{
						lines = function()
							math.randomseed(os.time())

							if not ascii_arts_table or #ascii_arts_table == 0 then
								return {}
							end

							local random_index = math.random(#ascii_arts_table)
							local random_art_entry = ascii_arts_table[random_index]

							local result = {}
							for _ = 1, 5 do
								table.insert(result, "")
							end

							if random_art_entry and random_art_entry.ascii_art and random_art_entry.colorOpts then
								for _, line in ipairs(random_art_entry.ascii_art) do
									local formatted_line = {
										{
											line,
											colorOpts = random_art_entry.colorOpts,
										},
									}
									table.insert(result, formatted_line)
								end
							end

							return result
						end,
					},
					{ "recents", topBuffer = 5 },
					{ "remaps", topBuffer = 20, title = "" },
				},

				-- toggle or set file and directory icons.
				--  For example, the following can be used to set different icons `{ file = " ", dir = " ", remaps = " ", pinned = " ", today = " ", yesterday = " ", week = " ", month = " ", long = " ", news = "󱀄 " }`
				icons = true,

				-- For true speed, it has the type string[][],
				--  each element of the shortcuts array contains two strings, the first is the key, the second is a match string to a directory
				--   for example, I have ~/.config/nvim as shortcut f, so I can type `f` to go to my neovim dotfiles, this is set with { { "f", ".config/nvim" } }
				shortcuts = {
					{ "x", ".config/nvim" },
				},

				--- Set to true to have more verbose logging
				debug = false,

				-- The path to the log file
				logPath = vim.fn.stdpath("log") .. "/spaceport.log",
				-- How many hours to preserve each log entry for
				logPreserveHrs = 24,
			})

			local original_values = {
				listchars = vim.opt.listchars:get(),
				statuscolumn = vim.o.statuscolumn,
			}

			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "SpaceportEnter",
				callback = function()
					vim.opt.listchars = {}
					vim.o.statuscolumn = ""
				end,
			})

			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "SpaceportDone",
				callback = function()
					vim.opt.listchars = original_values.listchars
					vim.o.statuscolumn = original_values.statuscolumn
				end,
			})
		end,
	},
}
