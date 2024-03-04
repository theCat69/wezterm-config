local lua_config_common = require 'lua-config-common.table-utils'
local wezterm = require 'wezterm'

local M = {}

-- go at bottom of the file to change theme
local light_theme = {
  color_scheme = 'Github (base16)',
}

local dark_theme = {
  color_scheme = 'astromouse (terminal.sexy)',
  -- window_background_image_hsb = {
  --   -- Darken the background image by reducing it to 1/3rd
  --   brightness = 0.3,
  --
  --   -- You can adjust the hue by scaling its value.
  --   -- a multiplier of 1.0 leaves the value unchanged.
  --   hue = 1.0,
  --
  --   -- You can adjust the saturation also.
  --   saturation = 1.0,
  -- },
  -- window_background_image = os.getenv('HOME') .. '/.config/wezterm/wezterm_assets/lampadere.jpg',
}

local os_theme = os.getenv('OS_THEME')
local theme = {}

if os_theme == 'dark' or os_theme == 'DARK' or os_theme == 'Dark' then
  theme = dark_theme
else
  theme = light_theme
end

local fonts = {
  font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Bold' },
    'Nerd Font Symbols',
    'Noto Color Emoji',
    'Nerd Font Mono',
  },
  font_size = 13,
  font_dirs = { 'fonts' },
}

local ui_conf = {
  -- this was use for the original dark theme
  hide_tab_bar_if_only_one_tab = true,
  window_background_opacity = 1.0,
  -- default is true, has more "native" look
  use_fancy_tab_bar = false,

  -- I don't like putting anything at the ege if I can help it.
  enable_scroll_bar = false,
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },
  freetype_load_target = "HorizontalLcd",
}

M.config = lua_config_common.table_merge(theme, fonts, ui_conf)

return M
