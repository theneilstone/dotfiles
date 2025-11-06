return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            python = { "black" },
            xml = { "xmllint" },
            json = { "jq" },
            yaml = { "prettier" },
            yml = { "prettier" },
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
            xmllint = {
                command = "xmllint",
                args = { "--format", "-" },
                stdin = true,
            },
            jq = {
                command = "jq",
                args = { "." },
                stdin = true,
            },
            prettier = {
                command = "prettier",
                args = { "--parser", "yaml" },
                stdin = true,
            },
        },
    },
}
