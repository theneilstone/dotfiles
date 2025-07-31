--[[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

  Personal Neovim Configuration
  Author:
  Version: 1.0
--]]

-- Bootstrap: Set up globals and essential settings before loading any modules
require("core.bootstrap")

-- Core Configuration: Load fundamental settings in proper order
require("core.options")     -- Editor options and behaviors
require("core.keymaps")     -- Key mappings and shortcuts
-- require("core.autocmds")    -- Auto commands and event handlers

-- Plugin Management: Initialize plugin manager and load plugins
require("core.lazy")        -- Lazy.nvim plugin manager setup

-- UI & Theme: Load visual configuration last
require("core.colorscheme") -- Color scheme and theme settings
