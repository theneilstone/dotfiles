--[[
  Keymaps Configuration

  All key mappings organized by mode and functionality.
  Uses consistent patterns and descriptive comments.
--]]

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Normal Mode Mappings
-- ============================================================================

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Window resizing
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Better scrolling
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Better search navigation
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- Clear search highlight (changed from <leader>h to avoid conflict with git hunks)
keymap.set("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Quick save and quit
keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- Clean whitespace
keymap.set("n", "<leader>cw", function()
  local save_cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])      -- Remove trailing whitespace
  vim.cmd([[%s/^\s\+$//e]])     -- Remove spaces from empty lines
  pcall(vim.api.nvim_win_set_cursor, 0, save_cursor)
  vim.notify("Cleaned whitespace in current buffer", vim.log.levels.INFO)
end, { desc = "Clean whitespace in current buffer" })

-- Buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Move text up and down
keymap.set("n", "<A-j>", ":move .+1<CR>==", opts)
keymap.set("n", "<A-k>", ":move .-2<CR>==", opts)

-- Better indenting
keymap.set("n", "<", "<<", opts)
keymap.set("n", ">", ">>", opts)

-- ============================================================================
-- Insert Mode Mappings
-- ============================================================================

-- Quick escape sequences
keymap.set("i", "jk", "<ESC>", opts)
keymap.set("i", "kj", "<ESC>", opts)

-- ============================================================================
-- Visual Mode Mappings
-- ============================================================================

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", opts)

-- Better paste (doesn't replace clipboard)
keymap.set("v", "p", '"_dP', opts)

-- ============================================================================
-- Visual Block Mode Mappings
-- ============================================================================

-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- ============================================================================
-- Terminal Mode Mappings
-- ============================================================================

-- Better terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- ============================================================================
-- Plugin-specific Keymaps (will be overridden by plugin configs)
-- ============================================================================

-- File Explorer
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Find file in explorer" })

-- ============================================================================
-- LSP Keymaps (set via autocmd in autocmds.lua)
-- ============================================================================

-- Remove conflicting default mappings
pcall(vim.keymap.del, "n", "grn")
pcall(vim.keymap.del, "n", "gra")
pcall(vim.keymap.del, "n", "grr")
pcall(vim.keymap.del, "n", "gri")
pcall(vim.keymap.del, "n", "gO")
