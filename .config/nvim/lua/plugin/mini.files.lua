return {
    "echasnovski/mini.files",
    version = false,
    opts = {},
    keys = {
        {
            "<leader>e",
            function()
                require("mini.files").open(vim.api.nvim_buf_get_name(0))
            end,
            desc = "Open file explorer",
        },
    },
}
