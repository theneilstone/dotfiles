return {
    "folke/tokyonight.nvim",
    config = function()
        require("tokyonight").setup({
            style = "night",
            on_colors = function(colors)
                colors.bg = "#000000"
                colors.bg_dark = "#000000"
                colors.bg_float = "#0a0a12"
                colors.bg_sidebar = "#0a0a12"
                colors.bg_statusline = "#0a0a12"
                colors.bg_popup = "#0a0a12"
                colors.bg_search = "#181820"
                colors.bg_visual = "#181820"
                colors.bg_highlight = "#181820"
            end,
        })
        vim.cmd.colorscheme("tokyonight-night")
    end,
}
