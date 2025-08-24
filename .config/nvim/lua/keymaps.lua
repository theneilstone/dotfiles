--[[
  Keymaps Configuration

  All key mappings organized by mode and functionality.
  Uses consistent patterns and descriptive comments.
--]]

-- Set leader key
vim.g.mapleader = " "        -- Space as leader key
vim.g.maplocalleader = " "   -- Space as local leader key

local keymap = vim.keymap

-- Helper function to create keymap options with description
local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- ============================================================================
-- Normal Mode Mappings
-- ============================================================================

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts("Move to left window"))
keymap.set("n", "<C-j>", "<C-w>j", opts("Move to bottom window"))
keymap.set("n", "<C-k>", "<C-w>k", opts("Move to top window"))
keymap.set("n", "<C-l>", "<C-w>l", opts("Move to right window"))

-- Window splitting
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts("Split window vertically"))
keymap.set("n", "<leader>sh", ":split<CR>", opts("Split window horizontally"))
keymap.set("n", "<leader>se", "<C-w>=", opts("Make windows equal size"))
keymap.set("n", "<leader>sx", ":close<CR>", opts("Close current split"))

-- Window resizing (Mac compatible and continuous)
-- Using Ctrl+Shift combinations for reliable terminal compatibility
keymap.set("n", "<C-S-h>", ":vertical resize -2<CR>", opts("Decrease window width"))
keymap.set("n", "<C-S-j>", ":resize +2<CR>", opts("Increase window height"))
keymap.set("n", "<C-S-k>", ":resize -2<CR>", opts("Decrease window height"))
keymap.set("n", "<C-S-l>", ":vertical resize +2<CR>", opts("Increase window width"))

-- Better scrolling
keymap.set("n", "<C-d>", "<C-d>zz", opts("Scroll down and center"))
keymap.set("n", "<C-u>", "<C-u>zz", opts("Scroll up and center"))

-- Better search navigation
keymap.set("n", "n", "nzzzv", opts("Next search result (centered)"))
keymap.set("n", "N", "Nzzzv", opts("Previous search result (centered)"))

-- Clear search highlight
keymap.set("n", "<Esc>", ":nohlsearch<CR>", opts("Clear search highlight"))

-- Quick save and quit
keymap.set("n", "<leader>w", ":write<CR>", opts("Save file"))
keymap.set("n", "<leader>q", ":quit<CR>", opts("Quit"))
keymap.set("n", "<leader>x", ":x<CR>", opts("Save and quit"))
keymap.set("n", "<leader>wa", ":wall<CR>", opts("Save all files"))
keymap.set("n", "<leader>qa", ":qall<CR>", opts("Quit all"))
keymap.set("n", "<leader>Q", ":qa!<CR>", opts("Quit all without saving"))

-- Clean whitespace (using <leader>cw - 'c' for clean/code group)
keymap.set("n", "<leader>cw", ":%s/\\s\\+$//e<CR>", opts("Remove trailing whitespace"))

-- Buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", opts("Next buffer"))
keymap.set("n", "<S-h>", ":bprevious<CR>", opts("Previous buffer"))
keymap.set("n", "<leader>bd", ":bdelete<CR>", opts("Close buffer"))
keymap.set("n", "<leader>bD", ":bdelete!<CR>", opts("Force close buffer"))
keymap.set("n", "<leader>ba", ":bufdo bdelete<CR>", opts("Close all buffers"))
keymap.set("n", "<C-6>", "<C-^>", opts("Toggle to last buffer"))

-- ============================================================================
-- Insert Mode Mappings
-- ============================================================================

-- Quick escape
keymap.set("i", "jk", "<ESC>", opts("Exit insert mode"))
keymap.set("i", "kj", "<ESC>", opts("Exit insert mode"))

-- Cursor movement in insert mode (using Ctrl combinations that work on macOS)
keymap.set("i", "<C-f>", "<Right>", opts("Move cursor right"))
keymap.set("i", "<C-b>", "<Left>", opts("Move cursor left"))
keymap.set("i", "<C-n>", "<Down>", opts("Move cursor down"))
keymap.set("i", "<C-p>", "<Up>", opts("Move cursor up"))

-- Line operations in insert mode
keymap.set("i", "<C-a>", "<Home>", opts("Move to line start"))
keymap.set("i", "<C-e>", "<End>", opts("Move to line end"))

-- Delete operations in insert mode
keymap.set("i", "<C-d>", "<Delete>", opts("Delete character forward"))
keymap.set("i", "<C-u>", "<C-u>", opts("Delete to line start"))
keymap.set("i", "<C-k>", "<C-o>D", opts("Delete to line end"))

-- Alternative arrow key bindings for when you don't want to reach for arrow keys
keymap.set("i", "<C-h>", "<BS>", opts("Backspace"))

-- ============================================================================
-- Visual Mode Mappings
-- ============================================================================

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts("Indent left and reselect"))
keymap.set("v", ">", ">gv", opts("Indent right and reselect"))

-- Move text up and down (cross-platform compatible)
-- Mac uses Option key (<M->) and Linux uses Alt key (<A->)
keymap.set("v", "<M-j>", ":move '>+1<CR>gv=gv", opts("Move selection down (Mac)"))
keymap.set("v", "<M-k>", ":move '<-2<CR>gv=gv", opts("Move selection up (Mac)"))
keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", opts("Move selection down (Linux)"))
keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", opts("Move selection up (Linux)"))

-- Better paste
keymap.set("v", "p", '"_dP', opts("Paste without losing clipboard"))

-- ============================================================================
-- File Navigation
-- ============================================================================

-- File explorer (Note: <leader>e is handled by neo-tree plugin)
-- keymap.set("n", "<leader>e", ":Explore<CR>", opts("Open file explorer"))
keymap.set("n", "<leader>E", ":Explore<CR>", opts("Open netrw explorer"))
keymap.set("n", "<leader>ef", ":Explore %:p:h<CR>", opts("Explore current file directory"))

-- ============================================================================
-- LSP Keymaps
-- ============================================================================

-- LSP navigation
keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
keymap.set("n", "K", vim.lsp.buf.hover, opts("Show hover info"))
keymap.set("n", "gr", vim.lsp.buf.references, opts("Show references"))
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code actions"))

-- ============================================================================
-- Search and Replace
-- ============================================================================

-- Quick search and replace (using <leader>r to avoid conflict with sessions)
keymap.set("n", "<leader>r", ":%s/", opts("Search and replace in buffer"))
keymap.set("v", "<leader>r", ":s/", opts("Search and replace in selection"))

-- Search for word under cursor
keymap.set("n", "<leader>*", "*N", opts("Search word under cursor"))

-- ============================================================================
-- Additional Useful Mappings
-- ============================================================================

-- Tab management
keymap.set("n", "<leader>tn", ":tabnew<CR>", opts("New tab"))
keymap.set("n", "<leader>tc", ":tabclose<CR>", opts("Close tab"))
keymap.set("n", "<leader>to", ":tabonly<CR>", opts("Close other tabs"))
keymap.set("n", "<leader>1", "1gt", opts("Go to tab 1"))
keymap.set("n", "<leader>2", "2gt", opts("Go to tab 2"))
keymap.set("n", "<leader>3", "3gt", opts("Go to tab 3"))
keymap.set("n", "<leader>4", "4gt", opts("Go to tab 4"))
keymap.set("n", "<leader>5", "5gt", opts("Go to tab 5"))

-- Terminal mappings
keymap.set("n", "<leader>tt", ":terminal<CR>", opts("Open terminal"))
keymap.set("n", "<leader>tv", ":vs | terminal<CR>", opts("Open terminal in vertical split"))
keymap.set("n", "<leader>th", ":split | terminal<CR>", opts("Open terminal in horizontal split"))
keymap.set("t", "<Esc>", "<C-\\><C-n>", opts("Exit terminal mode"))
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts("Terminal: move to left window"))
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts("Terminal: move to bottom window"))
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts("Terminal: move to top window"))
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", opts("Terminal: move to right window"))

-- Copy to system clipboard
keymap.set({"n", "v"}, "<leader>y", '"+y', opts("Copy to system clipboard"))
keymap.set("n", "<leader>Y", '"+Y', opts("Copy line to system clipboard"))

-- Paste from system clipboard
keymap.set({"n", "v"}, "<leader>p", '"+p', opts("Paste from system clipboard"))
keymap.set({"n", "v"}, "<leader>P", '"+P', opts("Paste before from system clipboard"))

-- Quick navigation (H and L for line start/end)
keymap.set("n", "H", "^", opts("Go to first non-blank character"))
keymap.set("n", "L", "$", opts("Go to end of line"))

-- Center cursor after jumping
keymap.set("n", "G", "Gzz", opts("Go to end and center"))
keymap.set("n", "gg", "ggzz", opts("Go to start and center"))
keymap.set("n", "}", "}zz", opts("Next paragraph and center"))
keymap.set("n", "{", "{zz", opts("Previous paragraph and center"))

-- Join lines but keep cursor position
keymap.set("n", "J", "mzJ`z", opts("Join lines and restore cursor"))

-- Undo break points
keymap.set("i", ",", ",<C-g>u", opts("Add undo break point"))
keymap.set("i", ".", ".<C-g>u", opts("Add undo break point"))
keymap.set("i", "!", "!<C-g>u", opts("Add undo break point"))
keymap.set("i", "?", "?<C-g>u", opts("Add undo break point"))

-- Quick fold toggle
keymap.set("n", "<leader>z", "za", opts("Toggle fold"))
keymap.set("n", "<leader>Z", "zA", opts("Toggle all folds"))

-- Diagnostic navigation (using <leader>D to avoid conflict with diff operations)
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts("Show diagnostic"))
keymap.set("n", "<leader>Dl", vim.diagnostic.setloclist, opts("Diagnostic list"))
