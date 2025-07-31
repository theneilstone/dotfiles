--[[
  Bootstrap Configuration

  Essential settings that must be loaded before anything else.
  This includes global variables, leader keys, and performance optimizations.
--]]

-- Set leader keys early (must be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Performance: Disable unnecessary built-in plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

-- Disable plugins for faster startup
for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Essential globals
vim.g.loaded_netrw = 1       -- Disable netrw for nvim-tree
vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin

-- Python provider settings (optional performance boost)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
