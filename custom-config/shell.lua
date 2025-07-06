local wezterm = require 'wezterm'

local dev_path = os.getenv('DEV')
local dot_files = os.getenv('DOTFILES')

local M = {}

local default_prog = {}
local set_environment_variables = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  set_environment_variables = {
    -- use a more ls-like output format for dir
    DIRCMD = '/d'
  }
  -- And inject clink into the command prompt
  default_prog = { 'cmd.exe', '/s', '/k', dev_path .. '/terminal/clink/clink_x64.exe', 'inject', '-q', '&&',
    'doskey', '/macrofile=' .. dot_files .. '/.config/clink/dos_macrofile' }
else -- Assuming linux environment
  set_environment_variables = {}
end

local shell_config = {
  set_environment_variables = set_environment_variables,
  default_prog = default_prog,
  default_cwd = dev_path
}

M.config = shell_config
M.default_prog = default_prog
M.set_environment_variables = set_environment_variables

return M
