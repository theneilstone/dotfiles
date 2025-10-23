return {
    "jbyuki/venn.nvim",
    config = function()
        -- venn.nvim: enable or disable keymappings
        function _G.Toggle_venn()
            local venn_enabled = vim.inspect(vim.b.venn_enabled)
            if venn_enabled == "nil" then
                vim.b.venn_enabled = true
                vim.cmd([[setlocal ve=all]])
                -- draw a line on HJKL keystokes
                vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { buffer = true, noremap = true })
                vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { buffer = true, noremap = true })
                vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", { buffer = true, noremap = true })
                vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { buffer = true, noremap = true })
                -- draw a box by pressing "gF" with visual selection
                vim.keymap.set("v", "gF", ":VBox<CR>", { buffer = true, noremap = true })
            else
                vim.cmd([[setlocal ve=]])
                pcall(vim.keymap.del, "n", "J", { buffer = true })
                pcall(vim.keymap.del, "n", "K", { buffer = true })
                pcall(vim.keymap.del, "n", "L", { buffer = true })
                pcall(vim.keymap.del, "n", "H", { buffer = true })
                pcall(vim.keymap.del, "v", "gF", { buffer = true })
                vim.b.venn_enabled = nil
            end
        end
        -- toggle keymappings for venn using <leader>v
        vim.keymap.set("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
    end,
}
