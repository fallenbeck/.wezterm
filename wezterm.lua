-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- The documentation of the config options can be found here:
-- https://wezfurlong.org/wezterm/config/lua/config/index.html

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
-- https://wezfurlong.org/wezterm/config/lua/config/index.html

-- Initial terminal size
config.initial_cols = 132
config.initial_rows = 42

-- Font
config.font = wezterm.font('Hack Nerd Font')

-- Set the size measured in points
config.font_size = 14.0

-- For example, changing the color scheme:
-- Find builtin-color schemes here:
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'GruvboxDark'

-- We do not use the tab bar (we use tmux)
config.enable_tab_bar = false

-- Set the opacity of the terminal window
config.window_background_opacity = 0.9
-- config.text_background_opacity = 0.5
config.macos_window_background_blur = 40

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
        regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
        format = '$0',
    },
    -- linkify email addresses
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
        regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
        format = 'mailto:$0',
    },
    -- file:// URI
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
        regex = [[\bfile://\S*\b]],
        format = '$0',
    },
    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    {
        regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
        format = '$0',
    },
    -- Make task numbers clickable
    -- The first matched regex group is captured in $1.
    {
        regex = [[\b[tT](\d+)\b]],
        format = 'https://example.com/tasks/?t=$1',
    },
    -- Make username/project paths clickable. This implies paths like the following are for GitHub.
    -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
    -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
    -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
    {
        regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
        format = 'https://www.github.com/$1/$3',
    },
}

-- WezTerm does not start in a Proxmox VM - debug output
-- local gpus = wezterm.gui.enumerate_gpus()
-- print(gpus)
-- config.front_end = "WebGpu"
-- config.webgpu_force_fallback_adapter = true

-- and finally, return the configuration to wezterm
return config
