return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "yaml",
                "toml",
                "scheme",
                "scala",
                "rust",
                "python",
                "ocaml",
                "make",
                "json",
                "llvm",
                "dockerfile",
                "git_rebase",
                "gitcommit",
                "gitattributes",
                "gitignore",
                "gomod",
                "go",
                "diff",
                "markdown_inline",
            },

            sync_install = false,
            auto_install = true,
            ignore_install = { "javascript" },

            -- Syntax highlighting
            highlight = {
                enable = true,
                disable = { "c", "rust" },
                additional_vim_regex_highlighting = false,
            },

            -- Indentation based on treesitter
            indent = {
                enable = true,
            },

            -- Incremental selection
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gss",
                    node_incremental = "gsi",
                    scope_incremental = "gsc",
                    node_decremental = "gsd",
                },
            },

            -- Text objects
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                    },
                    include_surrounding_whitespace = true,
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        ["]o"] = "@loop.*",
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                    goto_next = {
                        ["]d"] = "@conditional.outer",
                    },
                    goto_previous = {
                        ["[d"] = "@conditional.outer",
                    },
                },
            },
        })
        require("treesitter-context").setup({
            enable = true,
            max_lines = 3,
            min_window_height = 20,
            line_numbers = true,
            multiline_threshold = 1,
            trim_scope = "outer",
            mode = "cursor",
        })

        -- Setup folding
        vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
            group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
            callback = function()
                vim.opt.foldmethod = "expr"
                vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.opt.foldenable = false
            end,
        })
    end,
}