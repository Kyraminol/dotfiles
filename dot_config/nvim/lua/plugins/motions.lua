return {
	{
		"chrisgrieser/nvim-spider",
		config = function()
			require("spider").setup({
				skipInsignificantPunctuation = true,
				subwordMovement = true,
				consistentOperatorPending = true,
			})
		end,
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
			{ "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
		},
		lazy = true,
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		opts = {
			keymaps = {
				useDefaults = true,
			},
		},
	},
}
