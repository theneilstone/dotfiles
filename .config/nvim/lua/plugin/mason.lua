return {
    "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        local mr = require("mason-registry")
        local packages = {
            -- LSP servers
            "lua-language-server", -- Lua
            "clangd", -- C/C++
            "ty", -- Python
            -- Formatters
            "stylua", -- Lua
            "black", -- Python
            "clang-format", -- C/C++
            -- Linters
            "luacheck", -- Lua
        }

        mr:on("package:install:success", function()
            vim.cmd("doautocmd FileType")
        end)

        for _, pkg in ipairs(packages) do
            if not mr.get_package(pkg):is_installed() then
                mr.get_package(pkg):install()
            end
        end
    end,
}