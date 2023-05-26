-- Pull in the wezterm API
local wezterm = require 'wezterm'
local gpus = wezterm.gui.enumerate_gpus()

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
--
-- Font
config.font = wezterm.font('Hack')

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

-- WezTerm does not start in my VM
-- print(gpus)
-- config.front_end = "WebGpu"
-- config.webgpu_force_fallback_adapter = true

-- and finally, return the configuration to wezterm
return config
