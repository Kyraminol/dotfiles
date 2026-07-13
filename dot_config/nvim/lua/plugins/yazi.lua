return ---@type LazySpec
{
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			local group = vim.api.nvim_create_augroup("NoNetrwEmptyBuffer", { clear = true })

			vim.api.nvim_create_autocmd("VimEnter", {
				group = group,
				callback = function(data)
					if vim.fn.isdirectory(data.file) == 1 then
						vim.api.nvim_set_current_dir(data.file)
						vim.cmd.enew()
						vim.cmd.bwipeout(data.buf)
					end
				end,
			})
		end,
	},
}
