local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Kanagawa (Gogh)"
config.disable_default_key_bindings = false
config.enable_tab_bar = true
config.font = wezterm.font("Iosevka Nerd Font")
config.font_size = 16.0
config.front_end = "WebGpu"
config.max_fps = 120
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

local act = wezterm.action

config.keys = {
	-- macOS clipboard operations
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

	-- Navigation between words
	{ key = "LeftArrow", mods = "ALT", action = act.SendKey({ key = "b", mods = "ALT" }) },
	{ key = "RightArrow", mods = "ALT", action = act.SendKey({ key = "f", mods = "ALT" }) },

	-- Font size adjustments
	{ key = "+", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },

	-- Pane splitting
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- { key = "t", mods = "CMD", action = tmux("c") },
	-- { key = "w", mods = "CMD", action = tmux("&") },
	--
	-- -- Window navigation by number
	-- { key = "1", mods = "CMD", action = tmux("1") },
	-- { key = "2", mods = "CMD", action = tmux("2") },
	-- { key = "3", mods = "CMD", action = tmux("3") },
	-- { key = "4", mods = "CMD", action = tmux("4") },
	-- { key = "5", mods = "CMD", action = tmux("5") },
	-- { key = "6", mods = "CMD", action = tmux("6") },
	-- { key = "7", mods = "CMD", action = tmux("7") },
	-- { key = "8", mods = "CMD", action = tmux("8") },
	-- { key = "9", mods = "CMD", action = tmux("9") },
	--
	--
	-- -- Pane splitting
	-- { key = "d", mods = "CMD", action = tmux("%") },
	-- { key = "d", mods = "CMD|SHIFT", action = tmux('"') },
	--
	-- -- Pane navigation
	-- { key = "h", mods = "CMD", action = tmux("h") },
	-- { key = "j", mods = "CMD", action = tmux("j") },
	-- { key = "k", mods = "CMD", action = tmux("k") },
	-- { key = "l", mods = "CMD", action = tmux("l") },
	--
	-- -- Pane resizing (requires tmux bind for Ctrl-b H/J/K/L)
	-- { key = "h", mods = "CMD|SHIFT", action = tmux_with_mods("H", "SHIFT") },
	-- { key = "j", mods = "CMD|SHIFT", action = tmux_with_mods("J", "SHIFT") },
	-- { key = "k", mods = "CMD|SHIFT", action = tmux_with_mods("K", "SHIFT") },
	-- { key = "l", mods = "CMD|SHIFT", action = tmux_with_mods("L", "SHIFT") },
	--
	-- -- Session/other management
	-- { key = "s", mods = "CMD", action = tmux("[") },
	-- { key = "r", mods = "CMD", action = tmux_with_mods("r", "SHIFT") },

	-- WezTerm-specific
	{ key = "q", mods = "CMD", action = act.QuitApplication },
	{ key = "n", mods = "CMD|SHIFT", action = act.SpawnWindow },
	{ key = "Enter", mods = "CMD", action = act.ToggleFullScreen },
}

return config
