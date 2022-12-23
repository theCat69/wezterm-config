local wezterm = require 'wezterm'
local act = wezterm.action

local default_prog
local set_environment_variables = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Use OSC 7 as per the above example
  -- this will display, the current time and the current folder
  -- Don't use only this because it will be ugly
  -- The rest of the prompt variable enhancement is in clink configuration (for git and the rest of the sentence)
  set_environment_variables['prompt'] = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m'

  -- use a more ls-like output format for dir
  set_environment_variables['DIRCMD'] = '/d'
  -- And inject clink into the command prompt
  default_prog = { 'cmd.exe', '/s', '/k', 'c:/dev/terminal/clink/clink_x64.exe', 'inject', '-q' }
end

return {
  default_prog = default_prog,
  set_environment_variables = set_environment_variables,
  color_scheme = 'astromouse (terminal.sexy)',
  default_cwd = os.getenv('DEV'),
  window_background_image = os.getenv('HOME') .. '/.config/wezterm_assets/wezterm_forest_wallpapper.jpg',
  window_background_opacity = 1.0,
  window_background_image_hsb = {
    -- Darken the background image by reducing it to 1/3rd
    brightness = 0.2,

    -- You can adjust the hue by scaling its value.
    -- a multiplier of 1.0 leaves the value unchanged.
    hue = 1.0,

    -- You can adjust the saturation also.
    saturation = 1.0,
  },
  keys = {
    {
      key = 'h',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT|ALT',
      action = wezterm.action.SplitPane {
        direction = 'Down',
        size = { Percent = 25 },
      },
    },
    {
      key = 'q',
      mods = 'CTRL|SHIFT|ALT',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = 'F11',
      mods = '',
      action = wezterm.action.ToggleFullScreen,
    },
  },
}
