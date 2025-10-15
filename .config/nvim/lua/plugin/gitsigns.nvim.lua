return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_opts = { delay = 1000 },
        })
        vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
    end,
}
