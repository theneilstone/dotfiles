-- Define your colorscheme here.
local theme = "tokyonight"

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
if not is_ok then
	vim.notify("theme " .. theme .. " not found!")
	return
end
