return {
	{
		"bngarren/checkmate.nvim",
		ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
		config = function()
			require("checkmate").setup()
		end,
	},
}
