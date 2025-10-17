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

-- Window split
keymap.set("n", "<leader>sv", "<C-w>v", opts("Split window vertically"))
keymap.set("n", "<leader>sh", "<C-w>s", opts("Split window horizontally"))
keymap.set("n", "<leader>se", "<C-w>=", opts("Make splits equal size"))
keymap.set("n", "<leader>sx", "<cmd>close<CR>", opts("Close current split"))

-- Window resize mode (press <leader>r to enter, then use hjkl repeatedly)
keymap.set("n", "<leader>r", function()
    if vim.bo.buftype ~= "" then return end

    vim.g._resize_mode = true
    vim.notify("[Resize Mode] h/j/k/l=resize | e=equal | x=exit", vim.log.levels.INFO)

    local actions = {
        h = function() vim.cmd("vertical resize -3") end,  -- Decrease width
        j = function() vim.cmd("resize -2") end,           -- Decrease height
        k = function() vim.cmd("resize +2") end,           -- Increase height
        l = function() vim.cmd("vertical resize +3") end,  -- Increase width
        e = function() vim.cmd("wincmd =") end,            -- Equalize windows
    }

    while true do
        vim.cmd("redraw")  -- Force redraw to update display
        local ok, char = pcall(vim.fn.getchar)
        if not ok then break end
        local key = type(char) == "number" and vim.fn.nr2char(char) or char
        if key == "x" then
            vim.g._resize_mode = false
            vim.cmd("redraw")
            vim.notify("Exited resize mode", vim.log.levels.INFO)
            break
        end
        local action = actions[key]
        if action then
            pcall(action)
        end
    end
    vim.g._resize_mode = false
    vim.cmd("redraw")
end, opts("Enter window resize mode"))

-- Quick escape
keymap.set("i", "jk", "<ESC>", opts("Exit insert mode"))
keymap.set("i", "kj", "<ESC>", opts("Exit insert mode"))

-- Save and quit
keymap.set("n", "<leader>w", "<cmd>w<CR>", opts("Save file"))
keymap.set("n", "<leader>q", "<cmd>q<CR>", opts("Quit"))
keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", opts("Quit all without saving"))
keymap.set("n", "<leader>x", "<cmd>x<CR>", opts("Save and quit"))

-- Indent
keymap.set("v", "<", "<gv", opts("Indent left"))
keymap.set("v", ">", ">gv", opts("Indent right"))

-- Comment
keymap.set("n", "gcc", "gcc", { remap = true, desc = "Toggle comment line" })
keymap.set("v", "gc", "gc", { remap = true, desc = "Toggle comment" })
