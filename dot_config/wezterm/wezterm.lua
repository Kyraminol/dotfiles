local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("Cascadia Code NF", { weight="Regular", stretch="Normal", style="Normal" })
config.enable_tab_bar = false
config.default_prog = { 'nu' }
config.window_padding = {
  left = '0.5cell',
  right = '0',
  top = '0.5cell',
  bottom = '0',
}

return config
