--[[
  Neovim Configuration Entry Point

  Main configuration file that loads all other modules.
  Organized for clarity and maintainability.
--]]

-- Load configuration modules
require("options")  -- Editor options and settings
require("keymaps")  -- Key mappings and shortcuts
require("plugins")  -- Plugin management and configuration