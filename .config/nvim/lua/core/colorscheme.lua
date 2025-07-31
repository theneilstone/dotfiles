--[[
  Colorscheme Configuration

  Theme setup and customizations.
  Handles fallbacks and custom highlight groups.
--]]

-- Default colorscheme
local colorscheme = "tokyonight"

-- Safely load colorscheme
local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found! Using default.", vim.log.levels.WARN)
  vim.cmd.colorscheme("default")
end

-- Custom highlight groups
local function set_custom_highlights()
  -- Only apply custom highlights if not using tokyonight
  -- TokyoNight already provides excellent defaults
  local current_colorscheme = vim.g.colors_name
  if current_colorscheme == "tokyonight" then
    return -- Let TokyoNight handle all highlights
  end

  local highlights = {
    -- Make comments more visible
    Comment = { italic = true },

    -- Customize cursor line
    CursorLine = { bg = "#2d3748" },

    -- Make line numbers more subtle
    LineNr = { fg = "#4a5568" },
    LineNrAbove = { fg = "#4a5568" },
    LineNrBelow = { fg = "#4a5568" },

    -- Enhance visual selection
    Visual = { bg = "#3d4954" },

    -- Customize floating windows
    NormalFloat = { bg = "#1a202c" },
    FloatBorder = { fg = "#4a5568", bg = "#1a202c" },

    -- Make matching parentheses more visible
    MatchParen = { bold = true, underline = true },
  }

  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

-- Apply custom highlights after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("CustomHighlights", { clear = true }),
  desc = "Apply custom highlight groups",
  callback = set_custom_highlights,
})

-- Apply highlights immediately
set_custom_highlights()
