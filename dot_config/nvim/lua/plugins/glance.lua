return {
	{
		"dnlhc/glance.nvim",
		config = function()
			local glance = require("glance")

			glance.setup({
				height = 18, -- Height of the window
				zindex = 45,

				-- By default glance will open preview "embedded" within your active window
				-- when `detached` is enabled, glance will render above all existing windows
				-- and won't be restiricted by the width of your active window
				detached = true,

				-- Or use a function to enable `detached` only when the active window is too small
				-- (default behavior)
				-- detached = function(winid)
				-- 	return vim.api.nvim_win_get_width(winid) < 100
				-- end,

				preview_win_opts = { -- Configure preview window options
					cursorline = true,
					number = true,
					wrap = true,
					enable = true,
					top_char = "―",
					bottom_char = "―",
				},
				border = {
					enable = false, -- Show window borders. Only horizontal borders allowed
					top_char = "―",
					bottom_char = "―",
				},
				list = {
					position = "right", -- Position of the list window 'left'|'right'
					width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
				},
				theme = { -- This feature might not work properly in nvim-0.7.2
					enable = true, -- Will generate colors for the plugin based on your current colorscheme
					mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
				},
				mappings = {
					list = {
						["j"] = glance.actions.next, -- Bring the cursor to the next item in the list
						["k"] = glance.actions.previous, -- Bring the cursor to the previous item in the list
						["<Down>"] = glance.actions.next,
						["<Up>"] = glance.actions.previous,
						["<Tab>"] = glance.actions.next_location, -- Bring the cursor to the next location skipping groups in the list
						["<S-Tab>"] = glance.actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
						["<C-u>"] = glance.actions.preview_scroll_win(5),
						["<C-d>"] = glance.actions.preview_scroll_win(-5),
						["v"] = glance.actions.jump_vsplit,
						["s"] = glance.actions.jump_split,
						["t"] = glance.actions.jump_tab,
						["<CR>"] = glance.actions.jump,
						["o"] = glance.actions.jump,
						["l"] = glance.actions.open_fold,
						["h"] = glance.actions.close_fold,
						["<leader>l"] = glance.actions.enter_win("preview"), -- Focus preview window
						["q"] = glance.actions.close,
						["Q"] = glance.actions.close,
						["<Esc>"] = glance.actions.close,
						["<C-q>"] = glance.actions.quickfix,
						-- ['<Esc>'] = false -- disable a mapping
					},
					preview = {
						["Q"] = glance.actions.close,
						["<Tab>"] = glance.actions.next_location,
						["<S-Tab>"] = glance.actions.previous_location,
						["<leader>l"] = glance.actions.enter_win("list"), -- Focus list window
					},
				},
				hooks = {
					after_close = function() end,
					before_open = function() end,
					before_close = function() end,
				},
				folds = {
					fold_closed = "",
					fold_open = "",
					folded = true, -- Automatically fold list on startup
				},
				indent_lines = {
					enable = true,
					icon = "│",
				},
				winbar = {
					enable = true, -- Available strating from nvim-0.8+
				},
				use_trouble_qf = false, -- Quickfix action will open trouble.nvim instead of built-in quickfix list window
			})

			vim.keymap.set("n", "gGd", "<CMD>Glance definitions<CR>")
			vim.keymap.set("n", "gGr", "<CMD>Glance references<CR>")
			vim.keymap.set("n", "gGt", "<CMD>Glance type_definitions<CR>")
			vim.keymap.set("n", "gGi", "<CMD>Glance implementations<CR>")
		end,
	},
}
