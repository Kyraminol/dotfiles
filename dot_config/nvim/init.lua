-- [kickstart.nvim] settings
do
	-- vim.loader.enable()

	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	vim.g.have_nerd_font = true

	vim.o.number = true

	vim.o.mouse = "a"

	-- Hide mode, it's handled on statusline
	vim.o.showmode = false

	-- Sync clipboard between OS and Neovim
	vim.schedule(function()
		vim.o.clipboard = "unnamedplus"
	end)

	vim.o.breakindent = true

	vim.o.undofile = true

	-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
	vim.o.ignorecase = true
	vim.o.smartcase = true

	vim.o.signcolumn = "yes"

	vim.o.updatetime = 250

	vim.o.timeoutlen = 300

	-- Configure how new splits should be opened
	vim.o.splitright = true
	vim.o.splitbelow = true

	vim.o.list = true
	vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

	-- Preview substitutions live
	vim.o.inccommand = "split"

	vim.o.cursorline = true

	-- Minimal number of screen lines to keep above and below the cursor
	vim.o.scrolloff = 10

	vim.o.confirm = true
end

-- [custom] settings
do
	vim.g.editorconfig = false

	vim.o.statuscolumn =
		"%s%=%{printf('%' .. max([len(v:relnum), 3]) .. 'd', v:lnum)}│%=%{printf('%' .. max([len(v:lnum), 3]) .. 'd', v:relnum)}│%C"

	vim.opt.tabstop = 2
	vim.opt.softtabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.expandtab = true

	vim.opt.smartindent = true

	vim.opt.wrap = false
end

-- [kickstart.nvim] keymaps
do
	-- Clear highlights on search when pressing <Esc> in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

	vim.diagnostic.config({
		update_in_insert = false,
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },

		virtual_text = true, -- Text shows up at the end of the line
		virtual_lines = false, -- Text shows up underneath the line, with virtual lines

		-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
		jump = {
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float({
					bufnr = bufnr,
					scope = "cursor",
					focus = false,
				})
			end,
		},
	})

	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

	vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
	vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
	vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

	-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
	vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
	vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
	vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
	vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
		callback = function()
			vim.hl.hl_op()
		end,
	})
end

-- [custom] setup lazy.nvim
do
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			error("Error cloning lazy.nvim:\n" .. out)
		end
	end

	---@type vim.Option
	local rtp = vim.opt.rtp
	rtp:prepend(lazypath)

	require("lazy").setup({
		--  Import plugins from `lua/plugins/*.lua`.
		{ import = "plugins" },
	}, {
		ui = {
			-- If you are using a Nerd Font: set icons to an empty table which will use the
			-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
			icons = vim.g.have_nerd_font and {} or {
				cmd = "⌘",
				config = "🛠",
				event = "📅",
				ft = "📂",
				init = "⚙",
				keys = "🗝",
				plugin = "🔌",
				runtime = "💻",
				require = "🌙",
				source = "📄",
				start = "🚀",
				task = "📌",
				lazy = "💤 ",
			},
		},
	})
end
