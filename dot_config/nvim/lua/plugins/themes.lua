return {
	{
		"iagorrr/noctishc.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("noctishc")

			vim.cmd.hi("Comment gui=none")
		end,
	},
}
