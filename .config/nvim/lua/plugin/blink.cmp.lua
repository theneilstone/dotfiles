return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    version = "*",
    opts = {
        keymap = {
            preset = "enter",
            -- Select completions
            -- ["<Tab>"] = { "select_next", "fallback" },
            -- ["<S-Tab>"] = { "select_prev", "fallback" },
            -- Scroll documentation
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            -- Show/hide documentation
            ["<C-e>"] = { "show_documentation", "hide_documentation", "fallback" },
            -- Show/hide signature
            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            keyword = { range = "prefix" },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                },
            },
            trigger = { show_on_trigger_character = true },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
}

