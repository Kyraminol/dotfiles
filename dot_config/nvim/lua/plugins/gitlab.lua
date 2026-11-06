return {
	{
		"harrisoncramer/gitlab.nvim",
		branch = "develop",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"sindrets/diffview.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		build = function()
			require("gitlab.server").build(true)
		end,
		config = function()
			require("gitlab").setup()
		end,
	},
}
