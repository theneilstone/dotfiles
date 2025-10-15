-- Set leader key
vim.g.mapleader = " " -- Space as leader key
vim.g.maplocalleader = " " -- Space as local leader key

local keymap = vim.keymap

-- Helper function to create keymap options with description
local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts("Move to left window"))
keymap.set("n", "<C-j>", "<C-w>j", opts("Move to bottom window"))
keymap.set("n", "<C-k>", "<C-w>k", opts("Move to top window"))
keymap.set("n", "<C-l>", "<C-w>l", opts("Move to right window"))

-- Quick escape
keymap.set("i", "jk", "<ESC>", opts("Exit insert mode"))
keymap.set("i", "kj", "<ESC>", opts("Exit insert mode"))

-- Indent
keymap.set("v", "<", "<gv", opts("Indent left"))
keymap.set("v", ">", ">gv", opts("Indent right"))

-- Comment
keymap.set("n", "gcc", "gcc", { remap = true, desc = "Toggle comment line" })
keymap.set("v", "gc", "gc", { remap = true, desc = "Toggle comment" })
