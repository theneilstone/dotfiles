return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G", "Gdiff", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
		{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
		{ "<leader>gl", "<cmd>Git pull<cr>", desc = "Git Pull" },
		{ "<leader>gd", "<cmd>Gdiff<cr>", desc = "Git Diff" },
		{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
	},
}
