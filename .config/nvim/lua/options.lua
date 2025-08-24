--[[
  Neovim Options Configuration

  Editor settings and behavior configuration.
  Organized by functionality for easy maintenance.
--]]

local opt = vim.opt

-- ============================================================================
-- General Behavior Settings
-- ============================================================================

-- Mouse and clipboard
opt.mouse = "a"                           -- Enable mouse support
opt.clipboard = "unnamedplus"             -- Use system clipboard

-- ============================================================================
-- File Handling and Backup
-- ============================================================================

-- File backup settings
opt.swapfile = false                      -- Disable swap files
opt.backup = false                        -- Disable backup files
opt.undofile = true                       -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"  -- Undo directory

-- ============================================================================
-- Line Numbers and Visual Indicators
-- ============================================================================

-- Line numbers and visual guides
opt.number = true                         -- Show absolute line numbers
opt.relativenumber = true                 -- Show relative line numbers
opt.cursorline = true                     -- Highlight current line
opt.signcolumn = "yes"                    -- Always show sign column
opt.colorcolumn = "80"                    -- Show column guide at 80

-- ============================================================================
-- Window and Buffer Behavior
-- ============================================================================

-- Window splitting and scrolling
opt.splitbelow = true                     -- Horizontal splits below
opt.splitright = true                     -- Vertical splits right
opt.wrap = false                          -- Disable line wrapping
opt.scrolloff = 8                         -- Keep 8 lines visible when scrolling
opt.sidescrolloff = 8                     -- Keep 8 columns visible when scrolling

-- ============================================================================
-- Display and Appearance
-- ============================================================================

-- Visual appearance
opt.termguicolors = true                  -- Enable 24-bit RGB colors
opt.showmode = false                      -- Hide mode indicator
opt.conceallevel = 0                      -- Show all concealed text
opt.pumheight = 10                        -- Limit popup menu to 10 items
opt.cmdheight = 1                         -- Command line height

-- Whitespace visualization
opt.list = true                           -- Show invisible characters
opt.listchars = {
  trail = "·",                           -- Show trailing spaces as dots
  tab = "▸ ",                            -- Show tabs as arrows
  eol = "¬",                             -- Show end of line
  nbsp = "⦸",                            -- Show non-breaking spaces
  extends = "❯",                         -- Show line continues beyond screen
  precedes = "❮",                        -- Show line continues before screen
}

-- ============================================================================
-- Indentation and Tab Settings
-- ============================================================================

-- Tab and indentation
opt.tabstop = 4                           -- Tab width in spaces
opt.softtabstop = 4                       -- Spaces for tab in insert mode
opt.shiftwidth = 4                        -- Spaces for indentation
opt.expandtab = true                      -- Use spaces instead of tabs
opt.autoindent = true                     -- Copy indentation from current line
opt.smartindent = true                    -- Smart autoindenting

-- Comment formatting
opt.formatoptions:remove({ "c", "r", "o" })  -- Remove auto comment continuation

-- ============================================================================
-- Search Configuration
-- ============================================================================

-- Search behavior
opt.incsearch = true                      -- Show search matches incrementally
opt.hlsearch = false                      -- Don't highlight all matches
opt.ignorecase = true                     -- Ignore case when searching
opt.smartcase = true                      -- Override ignorecase if uppercase present

-- ============================================================================
-- Performance and Timing
-- ============================================================================

-- Timing settings
opt.updatetime = 250                      -- Faster completion updates
opt.timeoutlen = 1000                     -- Time to wait for key sequences (increased for easier typing)
opt.ttimeoutlen = 0                       -- Faster escape response
opt.lazyredraw = false                    -- Keep visual feedback during macros

-- ============================================================================
-- Completion and Command Line
-- ============================================================================

-- Completion settings
opt.completeopt = { "menu", "menuone", "noselect" }  -- Completion menu behavior
opt.wildmode = { "longest:full", "full" }             -- Command-line completion
opt.wildoptions = "pum"                               -- Use popup menu for completion

-- ============================================================================
-- Encoding and Word Boundaries
-- ============================================================================

-- Encoding and word boundaries
opt.fileencoding = "utf-8"                -- Use UTF-8 encoding
opt.iskeyword:append("-")                 -- Include hyphens in word boundaries

-- ============================================================================
-- Cursor Configuration
-- ============================================================================

-- Cursor visibility and behavior
opt.guicursor = {
  "n-v-c:block",                          -- Normal, visual, command mode: block cursor
  "i-ci-ve:hor40",                        -- Insert mode: horizontal underline cursor (40% height)
  "r-cr:hor20",                           -- Replace mode: horizontal line cursor (20% height)
  "o:hor50",                              -- Operator pending: horizontal line (50% height)
  "a:blinkwait700-blinkoff400-blinkon250", -- All modes: cursor blinking
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Select mode
}