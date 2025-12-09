-- Remove global default key mapping
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gO")

-- Diagnostic config
vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 4 },
    signs = {
        active = true,
        values = {
            Error = { text = "", texthl = "DiagnosticSignError" },
            Warn = { text = "", texthl = "DiagnosticSignWarn" },
            Hint = { text = "", texthl = "DiagnosticSignHint" },
            Info = { text = "", texthl = "DiagnosticSignInfo" },
        },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = { focusable = false, style = "minimal", border = "rounded", source = "always" },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    callback = function()
        vim.keymap.set("n", "<space>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end, { noremap = true, silent = true, buffer = true })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        local keymap = vim.keymap
        local lsp = vim.lsp
        local bufopts = { noremap = true, silent = true }

        keymap.set("n", "gr", lsp.buf.references, bufopts)
        keymap.set("n", "gd", lsp.buf.definition, bufopts)
        keymap.set("n", "<space>rn", lsp.buf.rename, bufopts)
        keymap.set("n", "<leader>K", lsp.buf.hover, bufopts)

        -- Diagnostic mappings (buffer-local) — avoid global conflicts
        keymap.set("n", "<leader>dd", vim.diagnostic.open_float, bufopts)
        keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, bufopts)
    end,
})

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/bin/")

vim.lsp.config("lua_ls", {
    cmd = { mason_path .. "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config("clangd", {
    cmd = { mason_path .. "clangd", "--clang-tidy", "--background-index", "--offset-encoding=utf-8" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git",
    },
})

vim.lsp.config("ty", {
    cmd = { mason_path .. "ty", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.cfg", "requirements.txt", ".git" },
})

vim.lsp.enable({ "lua_ls", "clangd", "ty" })
