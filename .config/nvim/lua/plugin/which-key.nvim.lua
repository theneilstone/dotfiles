return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			{ "<leader>f", group = "Find/Search" },
			{ "<leader>g", group = "Git" },
			{ "<leader>c", group = "Code" },
			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>t", group = "Toggle" },
		},
		win = { border = "rounded" },
	},
}
