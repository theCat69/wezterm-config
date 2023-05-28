local wezterm = require 'wezterm'
local act = wezterm.action

local default_prog
local set_environment_variables = {}

local dev_path = os.getenv('DEV')

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Use OSC 7 as per the above example
  -- this will display, the current time and the current folder
  -- Don't use only this because it will be ugly
  -- The rest of the prompt variable enhancement is in clink configuration (for git and the rest of the sentence)
  set_environment_variables['prompt'] = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m'

  -- use a more ls-like output format for dir
  set_environment_variables['DIRCMD'] = '/d'
  -- And inject clink into the command prompt
  default_prog = { 'cmd.exe', '/s', '/k', dev_path .. '/terminal/clink/clink_x64.exe', 'inject', '-q', '&&',
    'doskey', '/macrofile=' .. dev_path .. '/terminal/aliases/dos_macrofile' }
end

return {
  default_prog = default_prog,
  set_environment_variables = set_environment_variables,
  color_scheme = 'astromouse (terminal.sexy)',
  default_cwd = dev_path,
  window_background_image = os.getenv('HOME') .. '/.config/wezterm_assets/firewatch-dark-version-wallpaper.jpg',
  window_background_opacity = 1.0,
  window_background_image_hsb = {
    -- Darken the background image by reducing it to 1/3rd
    brightness = 0.3,

    -- You can adjust the hue by scaling its value.
    -- a multiplier of 1.0 leaves the value unchanged.
    hue = 1.0,

    -- You can adjust the saturation also.
    saturation = 1.0,
  },
  disable_default_key_bindings = true,
  keys = {
    { key = 'Tab', mods = 'CTRL',       action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    {
      key = 'g',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.SpawnCommandInNewTab {
        args = { 'gbb', 'ui' },
      },
    },
    { key = 't',         mods = 'SHIFT|CTRL',     action = act.SpawnTab 'CurrentPaneDomain' },
    { key = '+',         mods = 'SHIFT|CTRL',     action = act.IncreaseFontSize },
    { key = '-',         mods = 'SHIFT|CTRL',     action = act.DecreaseFontSize },
    { key = '0',         mods = 'SHIFT|CTRL',     action = act.ResetFontSize },
    { key = 'C',         mods = 'SHIFT|CTRL',     action = act.CopyTo 'Clipboard' },
    { key = 'F',         mods = 'SHIFT|CTRL',     action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'P',         mods = 'SHIFT|CTRL',     action = act.ActivateCommandPalette },
    { key = 'Q',         mods = 'ALT|SHIFT|CTRL', action = act.CloseCurrentPane { confirm = true } },
    { key = 'v',         mods = 'CTRL',           action = act.PasteFrom 'Clipboard' },
    { key = 'c',         mods = 'SHIFT|CTRL',     action = act.CopyTo 'Clipboard' },
    { key = 'LeftArrow', mods = 'SHIFT|ALT',      action = act.ActivatePaneDirection 'Left' },
    {
      key = 'LeftArrow',
      mods = 'SHIFT|CTRL',
      action = act.SplitPane { command = { domain = 'CurrentPaneDomain' }, direction =
      'Left' }
    },
    { key = 'LeftArrow',  mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'RightArrow', mods = 'SHIFT|ALT',      action = act.ActivatePaneDirection 'Right' },
    {
      key = 'RightArrow',
      mods = 'SHIFT|CTRL',
      action = act.SplitPane { command = { domain = 'CurrentPaneDomain' }, direction =
      'Right' }
    },
    { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'UpArrow',    mods = 'SHIFT|ALT',      action = act.ActivatePaneDirection 'Up' },
    {
      key = 'UpArrow',
      mods = 'SHIFT|CTRL',
      action = act.SplitPane { command = { domain = 'CurrentPaneDomain' }, direction =
      'Up' }
    },
    { key = 'UpArrow',   mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'DownArrow', mods = 'SHIFT|ALT',      action = act.ActivatePaneDirection 'Down' },
    {
      key = 'DownArrow',
      mods = 'SHIFT|CTRL',
      action = act.SplitPane { command = { domain = 'CurrentPaneDomain' }, direction = 'Down', size = { Percent = 30 } }
    },

    { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'F11',       mods = 'NONE',           action = act.ToggleFullScreen },
    { key = 'Copy',      mods = 'NONE',           action = act.CopyTo 'Clipboard' },
    { key = 'Paste',     mods = 'NONE',           action = act.PasteFrom 'Clipboard' },
  },
  key_tables = {
    -- i never use copy mode but i keep all the key mapping here in case i wanted to
    -- experience it one day
    copy_mode = {
      { key = 'Tab',    mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
      { key = 'Tab',    mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'Enter',  mods = 'NONE',  action = act.CopyMode 'MoveToStartOfNextLine' },
      { key = 'Escape', mods = 'NONE',  action = act.CopyMode 'Close' },
      { key = 'Space',  mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = '$',      mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '$',      mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = ',',      mods = 'NONE',  action = act.CopyMode 'JumpReverse' },
      { key = '0',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';',      mods = 'NONE',  action = act.CopyMode 'JumpAgain' },
      { key = 'F',      mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = false } } },
      { key = 'F',      mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } } },
      { key = 'G',      mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'G',      mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'H',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportTop' },
      { key = 'H',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'L',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'L',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'M',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'M',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'O',      mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'O',      mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'T',      mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = true } } },
      { key = 'T',      mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } } },
      { key = 'V',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = 'V',      mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = '^',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '^',      mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'b',      mods = 'NONE',  action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b',      mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b',      mods = 'CTRL',  action = act.CopyMode 'PageUp' },
      { key = 'c',      mods = 'CTRL',  action = act.CopyMode 'Close' },
      { key = 'd',      mods = 'CTRL',  action = act.CopyMode { MoveByPage = (0.5) } },
      { key = 'e',      mods = 'NONE',  action = act.CopyMode 'MoveForwardWordEnd' },
      { key = 'f',      mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = false } } },
      { key = 'f',      mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
      { key = 'f',      mods = 'CTRL',  action = act.CopyMode 'PageDown' },
      { key = 'g',      mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'g',      mods = 'CTRL',  action = act.CopyMode 'Close' },
      { key = 'h',      mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
      { key = 'j',      mods = 'NONE',  action = act.CopyMode 'MoveDown' },
      { key = 'k',      mods = 'NONE',  action = act.CopyMode 'MoveUp' },
      { key = 'l',      mods = 'NONE',  action = act.CopyMode 'MoveRight' },
      { key = 'm',      mods = 'ALT',   action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'o',      mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 'q',      mods = 'NONE',  action = act.CopyMode 'Close' },
      { key = 't',      mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = true } } },
      { key = 'u',      mods = 'CTRL',  action = act.CopyMode { MoveByPage = (-0.5) } },
      { key = 'v',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = 'v',      mods = 'CTRL',  action = act.CopyMode { SetSelectionMode = 'Block' } },
      { key = 'w',      mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
      {
        key = 'y',
        mods = 'NONE',
        action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, {
          CopyMode = 'Close' } }
      },
      { key = 'PageUp',     mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown',   mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'End',        mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = 'Home',       mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'LeftArrow',  mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'LeftArrow',  mods = 'ALT',  action = act.CopyMode 'MoveBackwardWord' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'RightArrow', mods = 'ALT',  action = act.CopyMode 'MoveForwardWord' },
      { key = 'UpArrow',    mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow',  mods = 'NONE', action = act.CopyMode 'MoveDown' },
    },
    -- i never use search_mode ever so same here ...
    search_mode = {
      { key = 'Enter',     mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape',    mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'n',         mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p',         mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r',         mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u',         mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp',    mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown',  mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow',   mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },
  },
}
