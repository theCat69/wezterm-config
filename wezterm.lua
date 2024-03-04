local lua_config_common = require 'lua-config-common.table-utils'
local ui = require 'custom-config.ui'
local shell = require 'custom-config.shell'
local keys = require 'custom-config.keys'

local config = lua_config_common.table_merge(ui.config, shell.config, keys.config)

return config
