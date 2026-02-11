local function lsp_status()
	local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
	if #attached_clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(attached_clients) do
		local name = client.name:gsub("language.server", "ls")
		table.insert(names, name)
	end
	return "LSP: " .. table.concat(names, ", ")
end

local function macro()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "Recording macro in: " .. reg
end

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local dmode_enabled = false
			vim.api.nvim_create_autocmd("User", {
				pattern = "DebugModeChanged",
				callback = function(args)
					dmode_enabled = args.data.enabled
				end,
			})
			require("lualine").setup({
				options = {
					globalstatus = true,
				},
				tabline = {
					lualine_a = {
						"buffers",
						mode = 0,
						max_length = vim.o.columns,
						symbols = {
							modified = " ●",
							alternate_file = "#",
							directory = "",
						},
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return dmode_enabled and "DEBUG" or str
							end,
							color = function(tb)
								return dmode_enabled and "dCursor" or tb
							end,
						},
					},
				},
				inactive_sections = {},
			})
		end,
	},
}
