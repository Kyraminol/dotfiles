return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })
		end,
	},
}
