local shell = require 'custom-config.shell'
local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

-- local domains = wezterm.mux.all_domains()
-- for i, v in pairs(domains) do
--   print(i, v)
--   local domain = wezterm.mux.get_domain(i)
--   if domain ~= nil then
--     print(domain:name())
--   end
-- end

-- i need to fix adjust pane size because those keys are already used on ubuntu for OS things
local key_config = {
  disable_default_key_bindings = true,
  keys = {
    { key = 'Tab', mods = 'CTRL',       action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    {
      key = 'g',
      mods = 'SHIFT|CTRL',
      action = act.SpawnCommandInNewTab {
        args = { 'gitui' },
      },
    },
    {
      key = '2',
      mods = 'SHIFT|CTRL',
      action = act.SpawnCommandInNewTab {
        label = 'Java 21',
        args = { 'bf-j-vm', 'j', 's', '21', '-l', '&&', table.unpack(shell.default_prog) },
      },
    },
    { key = 'U', mods = 'CTRL',       action = act.ScrollByPage(-1) },
    { key = 'D', mods = 'CTRL',       action = act.ScrollByPage(1) },
    { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    {
      key = '2',
      mods = 'SHIFT|CTRL',
      action = act.SpawnTab 'DefaultDomain',
    },
    {
      key = '3',
      mods = 'SHIFT|CTRL',
      action = act.SpawnTab {
        DomainName = 'WSL:Ubuntu-24.04',
      },
    },
    {
      key = '1',
      mods = 'SHIFT|CTRL',
      action = act.ShowLauncher
    },
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

M.config = key_config

return M
