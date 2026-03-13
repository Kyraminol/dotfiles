return {
	{
		"harrisoncramer/gitlab.nvim",
		branch = "develop",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
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
