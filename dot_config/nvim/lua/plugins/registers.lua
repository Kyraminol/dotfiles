return {
	{
		"https://codeberg.org/fosk/registers.nvim",
		event = "VeryLazy",
		cmd = "Registers",
		config = true,
		keys = {
			{ '"', mode = { "n", "v" } },
			{ "<C-R>", mode = "i" },
		},
	},
}
