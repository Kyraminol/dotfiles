return {
	{
		"alejandrosuero/freeze-code.nvim",
		event = "VeryLazy",
		config = function()
			require("freeze-code").setup({
				open = true,
				dir = vim.fn.expand("$HOME"),
				freeze_config = {
					output = "freeze.png",
					config = "./freeze-code.json",
					theme = "default",
				},
			})
		end,
	},
}
