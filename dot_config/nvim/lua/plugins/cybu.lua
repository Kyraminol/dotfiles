return {
	{
		"ghillb/cybu.nvim",
		branch = "main",
		event = "VeryLazy",
		config = function()
			local ok, cybu = pcall(require, "cybu")
			if not ok then
				return
			end
			cybu.setup({
				style = {
					devicons = {
						enabled = true,
						colored = true,
						truncate = true,
					},
				},
			})
			vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
			vim.keymap.set("n", "J", "<Plug>(CybuNext)")
			vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
			vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)")
		end,
	},
}
