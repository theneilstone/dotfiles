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

-- Window resize mode - smart direction detection
keymap.set("n", "<leader>r", function()
    if #vim.api.nvim_tabpage_list_wins(0) <= 1 then
        vim.notify("Only one window, nothing to resize", vim.log.levels.WARN)
        return
    end

    vim.g._resize_mode = true
    vim.notify("[Resize] h/l=width | j/k=height | e=equal | q=quit", vim.log.levels.INFO)

    -- Detect if we can move in a direction (returns true if split exists)
    local function can_move(direction)
        local cur_win = vim.api.nvim_get_current_win()
        vim.cmd("noautocmd wincmd " .. direction)
        local moved = vim.api.nvim_get_current_win() ~= cur_win
        if moved then
            -- Move back to restore position
            local reverse = ({ h = "l", l = "h", j = "k", k = "j" })[direction]
            vim.cmd("noautocmd wincmd " .. reverse)
        end
        return moved
    end

    -- Resize actions with step sizes
    local resize_actions = {
        h = {
            check = function()
                return can_move("h") or can_move("l")
            end,
            cmd = "vertical resize -3",
        },
        l = {
            check = function()
                return can_move("h") or can_move("l")
            end,
            cmd = "vertical resize +3",
        },
        k = {
            check = function()
                return can_move("k") or can_move("j")
            end,
            cmd = "resize -2",
        },
        j = {
            check = function()
                return can_move("k") or can_move("j")
            end,
            cmd = "resize +2",
        },
        e = {
            check = function()
                return true
            end,
            cmd = "wincmd =",
        },
    }

    -- Main input loop
    while true do
        local ok, char = pcall(vim.fn.getchar)
        if not ok then
            break
        end

        local key = type(char) == "number" and vim.fn.nr2char(char) or tostring(char)

        -- Exit on q, x, or ESC
        if key == "q" or key == "x" or char == 27 then
            break
        end

        -- Execute resize action if valid
        local action = resize_actions[key]
        if action and action.check() then
            vim.cmd(action.cmd)
            vim.cmd("redraw")
        end
    end

    vim.g._resize_mode = false
    vim.notify("Exited resize mode", vim.log.levels.INFO)
end, opts("Window resize mode"))

-- Quick escape
keymap.set("i", "jk", "<ESC>", opts("Exit insert mode"))
keymap.set("i", "kj", "<ESC>", opts("Exit insert mode"))
keymap.set("i", "<C-h>", "<Left>", opts("Insert mode: move left"))
keymap.set("i", "<C-n>", "<Down>", opts("Insert mode: move down"))
keymap.set("i", "<C-p>", "<Up>", opts("Insert mode: move up"))
keymap.set("i", "<C-l>", "<Right>", opts("Insert mode: move right"))

-- Save and quit
keymap.set("n", "<leader>w", "<cmd>w<CR>", opts("Save file"))
keymap.set("n", "<leader>q", "<cmd>q<CR>", opts("Quit"))
keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", opts("Quit all without saving"))
keymap.set("n", "<leader>x", "<cmd>x<CR>", opts("Save and quit"))

-- Tabs
keymap.set("n", "<Tab>", "gt", opts("Next tab"))
keymap.set("n", "<S-Tab>", "gT", opts("Previous tab"))
keymap.set("n", "<leader>tn", ":tabnew<CR>", opts("New tab"))
keymap.set("n", "<leader>tc", ":tabclose<CR>", opts("Close tab"))
for i = 1, 9 do
    keymap.set("n", "<leader>"..i, i.."gt", opts("Go to tab "..i))
end

keymap.set("v", "<", "<gv", opts("Indent left"))
keymap.set("v", ">", ">gv", opts("Indent right"))

-- Alternative for visual block mode (fix <C-v> conflict)
keymap.set("n", "<C-q>", "<C-v>", opts("Visual block mode (alternative to <C-v>)"))

-- Diff current and other split
keymap.set("n", "<leader>df", function()
    vim.cmd("windo diffthis")
end, opts("Diff current buffer with another file"))
