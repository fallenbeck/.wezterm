-- The documentation of the config options can be found here:
-- https://wezfurlong.org/wezterm/config/lua/config/index.html
-- sorted by tags:
-- https://wezfurlong.org/wezterm/tags.html

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

--
-- COLOR SCHEME
--

-- Find builtin-color schemes here:
-- https://wezfurlong.org/wezterm/colorschemes/index.html

-- https://github.com/catppuccin/WezTerm
-- (Optional) To enable syncing with your OS theme, use wezterm.gui.get_appearance()
function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- return "Catppuccin Mocha"
		return "GruvboxDark"
	-- return "Gruvbox Dark (Gogh)"
	else
		-- return "Papercolor Light (Gogh)"
		return "Catppuccin Latte"
	end
end
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Initial terminal size
config.initial_cols = 132
config.initial_rows = 42

-- Font
-- Display fonts available with
-- wezterm ls-fonts --list-system

-- Monaspace: https://monaspace.githubnext.com
-- config.font = wezterm.font('Monaspace Neon')
-- config.font = wezterm.font('Monaspace Argon')
-- config.font = wezterm.font('Monaspace Krypton')

-- Apple San Francisco Mono: https://developer.apple.com/fonts/
-- config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font = wezterm.font("Hack Nerd Font")

-- Fira Code: https://github.com/tonsky/FiraCode
-- config.font = wezterm.font('Fira Code')

-- Victor Mono: https://rubjo.github.io/victor-mono/
-- config.font = wezterm.font('Victor Mono')

-- JetBrains Mono: https://www.jetbrains.com/de-de/lp/mono/
-- config.font = wezterm.font('JetBrains Mono')

-- Nerd Fonts: https://www.nerdfonts.com
-- config.font = wezterm.font('Hack Nerd Font')

-- Hack Font: https://sourcefoundry.org/hack/
-- config.font = wezterm.font('Hack')

-- Nerd Fonts: https://www.nerdfonts.com
-- config.font = wezterm.font('Hack Nerd Font')

-- Focus pane that has been clicked on even if windows did
-- not have focus (comparable to Alacritty's behaviour)
config.swallow_mouse_click_on_window_focus = false
config.swallow_mouse_click_on_pane_focus = true

-- Set the size measured in points
config.font_size = 13

-- We do not use the tab bar (we use tmux)
-- config.enable_tab_bar = false
config.enable_tab_bar = true

-- Set the opacity of the terminal window

-- Perfect background opacity for a dark theme
-- config.window_background_opacity = 0.8

-- Light themes might look better with higher opacity
-- config.window_background_opacity = 0.7

-- Blur the background
-- config.macos_window_background_blur = 60

-- Window decorations
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = "RESIZE"

-- Sets the font for the window frame (tab bar)
config.window_frame = {
	-- Berkeley Mono for me again, though an idea could be to try a
	-- serif font here instead of monospace for a nicer look?
	font = wezterm.font({
		-- family = "Berkeley Mono",
		family = "Hack Nerd Font",
		weight = "Bold",
	}),
	font_size = 11,
}

-- Fixes to get [] and tilde ~ on german keyboards
config.use_ime = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.use_dead_keys = true

-- Clickable hyperlinks
-- make clickable hyperlinks work
config.hyperlink_rules = {
	-- Linkify things that look like URLs and the host has a TLD name.
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},
	-- linkify email addresses
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
		format = "mailto:$0",
	},
	-- file:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\bfile://\S*\b]],
		format = "$0",
	},
	-- vnc:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\bvnc://\S*\b]],
		format = "$0",
	},
	-- Linkify things that look like URLs with numeric addresses as hosts.
	-- E.g. http://127.0.0.1:8000 for a local development server,
	-- or http://192.168.1.1 for the web interface of many routers.
	{
		regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
		format = "$0",
	},
	-- Make task numbers clickable
	-- The first matched regex group is captured in $1.
	{
		regex = [[\b[tT](\d+)\b]],
		format = "https://example.com/tasks/?t=$1",
	},
	-- Make username/project paths clickable. This implies paths like the following are for GitHub.
	-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
	-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
	-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
	{
		regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
		format = "https://www.github.com/$1/$3",
	},
	-- The following are the default rules provided by
	-- wezterm.default_hyperlink_rules()
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
		format = "$0",
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

--
-- Custom functions
--

local function select_pane(key, direction)
	return {
		key = key,
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

local function select_tab(key, relative_direction)
	return {
		key = key,
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateTabRelative(relative_direction),
	}
end

local function move_tab(key, relative_direction)
	return {
		key = key,
		mods = "CMD|SHIFT|OPT",
		action = wezterm.action.MoveTabRelative(relative_direction),
	}
end

-- Powerline looking status bar
-- Source: https://alexplescan.com/posts/2024/08/10/wezterm/
local function segments_for_right_status(window)
	return {
		window:active_workspace(),
		wezterm.strftime("%a %b %-d %H:%M"),
		wezterm.hostname(),
	}
end

wezterm.on("update-status", function(window, _)
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	local segments = segments_for_right_status(window)

	local color_scheme = window:effective_config().resolved_palette
	-- Note the use of wezterm.color.parse here, this returns
	-- a Color object, which comes with functionality for lightening
	-- or darkening the colour (amongst other things).
	local bg = wezterm.color.parse(color_scheme.background)
	local fg = color_scheme.foreground

	-- Each powerline segment is going to be coloured progressively
	-- darker/lighter depending on whether we're on a dark/light colour
	-- scheme. Let's establish the "from" and "to" bounds of our gradient.
	local gradient_to, gradient_from = bg
	if wezterm.gui.get_appearance():find("Dark") then
		gradient_from = gradient_to:lighten(0.2)
	else
		gradient_from = gradient_to:darken(0.2)
	end

	-- Yes, WezTerm supports creating gradients, because why not?! Although
	-- they'd usually be used for setting high fidelity gradients on your terminal's
	-- background, we'll use them here to give us a sample of the powerline segment
	-- colours we need.
	local gradient = wezterm.color.gradient(
		{
			orientation = "Horizontal",
			colors = { gradient_from, gradient_to },
		},
		#segments -- only gives us as many colours as we have segments.
	)

	-- We'll build up the elements to send to wezterm.format in this table.
	local elements = {}

	for i, seg in ipairs(segments) do
		local is_first = i == 1

		if is_first then
			table.insert(elements, { Background = { Color = "none" } })
		end
		table.insert(elements, { Foreground = { Color = gradient[i] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = gradient[i] } })
		table.insert(elements, { Text = " " .. seg .. " " })
	end

	window:set_right_status(wezterm.format(elements))
end)

--
-- Environment variables
--
config.set_environment_variables = {
	PATH = "/usr/local/bin:" .. "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

--
-- Leader key
--
config.leader = {
	key = "b",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}

--
-- Custom key bindings
--

-- Define the keybindings itself
config.keys = {
	-- On macOS use `Cmd + ,` to open WezTerm's configuration file in NeoVim
	{
		key = ",",
		mods = "SUPER",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	},

	-- Nested multiplexing
	-- To send Ctrl-b to the terminal (i.e. when using tmux on remote machines)
	{
		key = "b",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({
			key = "b",
			mods = "CTRL",
		}),
	},

	-- Splitting panes
	{
		key = '"',
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "%",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- Selecting panes
	select_pane("j", "Down"),
	select_pane("k", "Up"),
	select_pane("h", "Left"),
	select_pane("l", "Right"),
	select_pane("DownArrow", "Down"),
	select_pane("UpArrow", "Up"),
	select_pane("LeftArrow", "Left"),
	select_pane("RightArrow", "Right"),

	-- Resizing panes: LEADER, r, {hjkl}
	{
		key = "r",
		mods = "LEADER",
		-- Activate the `resize_panes` keytable
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			-- Ensures the keytable stays active after it handles its first keypress.
			one_shot = false,
			-- Deactivate the keytable after a timeout.
			timeout_milliseconds = 1000,
		}),
	},

	-- Create new tab
	{
		key = "DownArrow",
		mods = "CMD|SHIFT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- Switching tabs
	select_tab("h", -1),
	select_tab("l", 1),
	select_tab("LeftArrow", -1),
	select_tab("RightArrow", 1),

	-- Moving tabs
	move_tab("h", -1),
	move_tab("l", 1),
	move_tab("LeftArrow", -1),
	move_tab("RightArrow", 1),
}

config.key_tables = {
	resize_panes = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
		resize_pane("DownArrow", "Down"),
		resize_pane("UpArrow", "Up"),
		resize_pane("LeftArrow", "Left"),
		resize_pane("RightArrow", "Right"),
	},
}

-- WezTerm does not start in a Proxmox VM - debug output
-- local gpus = wezterm.gui.enumerate_gpus()
-- print(gpus)
-- config.front_end = "WebGpu"
-- config.webgpu_force_fallback_adapter = true

-- and finally, return the configuration to wezterm
return config
