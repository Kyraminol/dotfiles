return {
	{
		"wurli/visimatch.nvim",
		event = "VeryLazy",
		config = function()
			require("visimatch").setup()
		end,
	},
}
