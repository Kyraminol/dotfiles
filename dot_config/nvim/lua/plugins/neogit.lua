return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local neogit = require("neogit")

			neogit.setup({
				highlight = {
					red = "#ffffff",
					line_red = "#990000",
				},
			})

			vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })
		end,
	},
}
