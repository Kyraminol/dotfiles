local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("Cascadia Code NF", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 10.0
config.line_height = 0.9
config.enable_tab_bar = false
config.default_prog = { "zellij" }
config.window_padding = {
	left = "0",
	right = "0",
	top = "0",
	bottom = "0",
}

return config
