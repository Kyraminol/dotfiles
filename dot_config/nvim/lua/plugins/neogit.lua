return {
	{
		"NeogitOrg/neogit",
		event = "VeryLazy",
		dependencies = {
			"sindrets/diffview.nvim",
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
