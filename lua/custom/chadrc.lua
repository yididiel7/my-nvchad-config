---@type ChadrcConfig
local M = {}

M.ui = { 
  theme = 'catppuccin_base64',
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    separator_style = "round", -- default/round/block/arrow separators
    overriden_modules = nil,
  },
}
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"
return M
