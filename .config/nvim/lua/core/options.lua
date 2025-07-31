--[[
  Editor Options Configuration

  Core Neovim settings for editing behavior, UI, and performance.
  Organized by category for better maintainability.
--]]

local opt = vim.opt

-- ============================================================================
-- General Settings
-- ============================================================================

opt.mouse = "a"                           -- Enable mouse support
opt.clipboard = "unnamedplus"             -- Use system clipboard
opt.swapfile = false                      -- Disable swap files
opt.backup = false                        -- Disable backup files
opt.undofile = true                       -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ============================================================================
-- UI Configuration
-- ============================================================================

opt.number = true                         -- Show line numbers
opt.relativenumber = true                 -- Show relative line numbers
opt.cursorline = true                     -- Highlight current line
opt.signcolumn = "yes"                    -- Always show sign column
opt.colorcolumn = "80"                    -- Show column guide at 80 characters

-- Window behavior
opt.splitbelow = true                     -- Split windows below current
opt.splitright = true                     -- Split windows to the right
opt.wrap = false                          -- Disable line wrapping
opt.scrolloff = 8                         -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8                     -- Keep 8 columns left/right of cursor

-- Visual enhancements
opt.termguicolors = true                  -- Enable 24-bit RGB colors
opt.showmode = false                      -- Hide mode display (shown in statusline)
opt.conceallevel = 0                      -- Show concealed text
opt.pumheight = 10                        -- Maximum items in popup menu
opt.cmdheight = 1                         -- Command line height

-- ============================================================================
-- Indentation & Formatting
-- ============================================================================

opt.tabstop = 4                           -- Number of spaces per tab
opt.softtabstop = 4                       -- Number of spaces per tab in editing
opt.shiftwidth = 4                        -- Number of spaces for indentation
opt.expandtab = true                      -- Convert tabs to spaces
opt.autoindent = true                     -- Copy indent from current line
opt.smartindent = true                    -- Smart autoindenting

-- Remove auto-commenting on new lines
opt.formatoptions:remove({ "c", "r", "o" })

-- ============================================================================
-- Search Configuration
-- ============================================================================

opt.incsearch = true                      -- Show search matches as you type
opt.hlsearch = false                      -- Don't highlight search results
opt.ignorecase = true                     -- Ignore case in search
opt.smartcase = true                      -- Case-sensitive if uppercase used

-- ============================================================================
-- Performance & Timing
-- ============================================================================

opt.updatetime = 250                      -- Faster completion (default: 4000ms)
opt.timeoutlen = 300                      -- Time to wait for key sequence
opt.ttimeoutlen = 0                       -- Time to wait for key codes
opt.lazyredraw = false                    -- Don't redraw during macros

-- ============================================================================
-- Completion
-- ============================================================================

opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmode = { "longest:full", "full" } -- Command line completion
opt.wildoptions = "pum"                   -- Use popup menu for completion

-- ============================================================================
-- File Handling
-- ============================================================================

opt.fileencoding = "utf-8"                -- File encoding
opt.iskeyword:append("-")                 -- Treat hyphenated words as one word

-- ============================================================================
-- Whitespace Management
-- ============================================================================

-- Show invisible characters (optional - uncomment to enable)
-- opt.list = true
-- opt.listchars = {
--   tab = "→ ",      -- Show tabs
--   trail = "·",     -- Show trailing spaces
--   extends = "⟩",   -- Show line extension
--   precedes = "⟨",  -- Show line precedes
--   nbsp = "␣",      -- Show non-breaking spaces
-- }

-- ============================================================================
-- Folding (optional - uncomment if needed)
-- ============================================================================

-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldlevel = 99
-- opt.foldcolumn = "1"

-- ============================================================================
-- AI/Copilot Settings
-- ============================================================================

-- Ensure Copilot suggestions are enabled
vim.g.ai_cmp = false                      -- Disable ai_cmp flag that might interfere with Copilot
