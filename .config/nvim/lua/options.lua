local opt = vim.opt

-- Mouse and clipboard
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard

-- File backup settings
opt.swapfile = false -- Disable swap files
opt.backup = false -- Disable backup files
opt.undofile = true -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Undo directory

-- Line numbers and visual guides
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight current line
opt.signcolumn = "yes" -- Always show sign column
opt.colorcolumn = { "80", "120" } -- Show column guide at 80

-- Window splitting and scrolling
opt.splitbelow = true -- Horizontal splits below
opt.splitright = true -- Vertical splits right
opt.wrap = false -- Disable line wrapping
opt.scrolloff = 8 -- Keep 8 lines visible when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns visible when scrolling

-- Visual appearance
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.showmode = false -- Hide mode indicator
opt.conceallevel = 0 -- Show all concealed text
opt.pumheight = 10 -- Limit popup menu to 10 items
opt.cmdheight = 1 -- Command line height

-- Whitespace visualization
opt.list = true -- Show invisible characters
opt.listchars = { trail = "·" } -- Show trailing spaces as dots

-- Tab and indentation
opt.tabstop = 4 -- Tab width in spaces
opt.softtabstop = 4 -- Spaces for tab in insert mode
opt.shiftwidth = 4 -- Spaces for indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.autoindent = true -- Copy indentation from current line
opt.smartindent = true -- Smart autoindenting

-- Search
opt.incsearch = true -- Show search matches incrementally
opt.hlsearch = false -- Don't highlight all matches
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Override ignorecase if uppercase present

-- Cursor visibility
opt.guicursor = {
    "n-v-c:block", -- Normal, visual, command mode: block cursor
    "i-ci-ve:hor40", -- Insert mode: horizontal underline cursor (40% height)
    "r-cr:hor20", -- Replace mode: horizontal line cursor (20% height)
    "o:hor50", -- Operator pending: horizontal line (50% height)
    "a:blinkwait700-blinkoff400-blinkon250", -- All modes: cursor blinking
    "sm:block-blinkwait175-blinkoff150-blinkon175", -- Select mode
}