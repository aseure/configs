local wezterm = require("wezterm")
local act = wezterm.action

local function send_alt(key)
	return act.SendKey({ key = key, mods = "ALT" })
end

-- \x02 is Ctrl-b, the tmux prefix
local function send_tmux(keys)
	return act.SendString("\x02" .. keys)
end

-- Cmd-c copies WezTerm's own selection (Shift-drag), else tmux's copy-mode selection
local copy_selection = wezterm.action_callback(function(window, pane)
	if window:get_selection_text_for_pane(pane) ~= "" then
		window:perform_action(act.CopyTo("Clipboard"), pane)
	else
		window:perform_action(send_tmux("Y"), pane)
	end
end)

local function tmux_window_keys()
	local keys = {}
	for i = 1, 9 do
		table.insert(keys, { key = tostring(i), mods = "CMD", action = send_alt(tostring(i)) })
	end
	return keys
end

local config = wezterm.config_builder()

config.animation_fps = 1
config.color_scheme = "nordic"
config.color_scheme_dirs = { wezterm.home_dir .. "/.local/share/nvim/lazy/nordic.nvim/platforms/wezterm" }
config.cursor_blink_rate = 0
config.enable_tab_bar = false
config.font = wezterm.font("Iosevka Nerd Font")
config.font_size = 16.0
config.front_end = "WebGpu"
config.max_fps = 60
config.mux_enable_ssh_agent = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "TITLE | RESIZE | MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"
config.window_padding = { left = 15, right = 15, top = 30, bottom = 15 }

config.keys = {
	{ key = "LeftArrow", mods = "ALT", action = act.SendKey({ key = "b", mods = "ALT" }) },
	{ key = "RightArrow", mods = "ALT", action = act.SendKey({ key = "f", mods = "ALT" }) },
	{ key = "Enter", mods = "CMD", action = act.ToggleFullScreen },
	{ key = "c", mods = "CMD", action = copy_selection },

	-- Cmd-hjkl send the Dvorak Alt-h/t/c/n navigation keys shared by tmux and Neovim
	{ key = "h", mods = "CMD", action = send_alt("h") },
	{ key = "j", mods = "CMD", action = send_alt("t") },
	{ key = "k", mods = "CMD", action = send_alt("c") },
	{ key = "l", mods = "CMD", action = send_alt("n") },

	{ key = "h", mods = "CMD|SHIFT", action = send_tmux("H") },
	{ key = "j", mods = "CMD|SHIFT", action = send_tmux("T") },
	{ key = "k", mods = "CMD|SHIFT", action = send_tmux("C") },
	{ key = "l", mods = "CMD|SHIFT", action = send_tmux("N") },

	{ key = "d", mods = "CMD", action = send_tmux("v") },
	{ key = "d", mods = "CMD|SHIFT", action = send_tmux("s") },
	{ key = "t", mods = "CMD", action = send_tmux("c") },
	{ key = "w", mods = "CMD", action = send_tmux("x") },
	{ key = "z", mods = "CMD", action = send_tmux("z") },
	{ key = "f", mods = "CMD", action = send_tmux("t") },
	{ key = "p", mods = "CMD", action = send_tmux("o") },
	{ key = "p", mods = "CMD|SHIFT", action = send_tmux("O") },
	{ key = "s", mods = "CMD", action = send_tmux(")") },
	{ key = "s", mods = "CMD|SHIFT", action = send_tmux("(") },
	{ key = "r", mods = "CMD", action = send_tmux("r") },
	{ key = "y", mods = "CMD", action = send_tmux("[") },
	{ key = "/", mods = "CMD", action = send_tmux("[?") },
}

for _, key in ipairs(tmux_window_keys()) do
	table.insert(config.keys, key)
end

return config
