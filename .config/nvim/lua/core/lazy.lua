--[[
  Lazy.nvim Plugin Manager Configuration
  
  Bootstrap and configure the Lazy.nvim plugin manager.
  Handles automatic installation and plugin loading.
--]]

-- Bootstrap lazy.nvim installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    -- Import all plugin configurations from plugins/ directory subdirectories
    { import = "plugins.editor" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.tools" },
    { import = "plugins.ui" },
  },
  defaults = {
    lazy = false, -- Plugins are not lazy-loaded by default
    version = false, -- Don't use version="*" by default
  },
  install = {
    colorscheme = { "tokyonight", "habamax" }, -- Try to load one of these colorschemes
  },
  checker = {
    enabled = true, -- Automatically check for plugin updates
    notify = false, -- Don't notify about updates
  },
  performance = {
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    -- Use a nice icon set for the lazy.nvim UI
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
