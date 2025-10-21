return {
    "xeluxee/competitest.nvim",
    lazy = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local template_path = vim.fn.expand("~/project/templates/")
        require("competitest").setup({
            companion_port = 27121,
            template_file = {
                cpp = template_path .. "template.cpp",
                py = template_path .. "template.py",
                java = template_path .. "template.java",
                js = template_path .. "template.js",
                rust = template_path .. "template.rs",
                go = template_path .. "template.go",
            },
            default_language = "cpp",
        })
    end,
    keys = {
        -- Receive problems/contests
        { "<leader>cr", "<cmd>CompetiTest receive problem<cr>", desc = "Receive Problem" },
        { "<leader>cR", "<cmd>CompetiTest receive contest<cr>", desc = "Receive Contest" },

        -- Run and test
        { "<leader>ct", "<cmd>CompetiTest run<cr>", desc = "Run Testcases" },
        { "<leader>ca", "<cmd>CompetiTest add_testcase<cr>", desc = "Add Testcase" },
        { "<leader>ce", "<cmd>CompetiTest edit_testcase<cr>", desc = "Edit Testcase" },
        { "<leader>cd", "<cmd>CompetiTest delete_testcase<cr>", desc = "Delete Testcase" },

        -- Display information
        { "<leader>ci", "<cmd>CompetiTest show_ui<cr>", desc = "Show UI" },
        { "<leader>co", "<cmd>CompetiTest convert<cr>", desc = "Convert Testcases" },
    },
}
