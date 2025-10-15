return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            python = { "black" },
        },
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            black = {
                prepend_args = { "--line-length", "88" },
            },
            ["clang-format"] = {
                prepend_args = { "--style={IndentWidth: 4, UseTab: Never}" },
            },
        },
    },
}

