return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { 
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>flg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find Word under Cursor" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
		{ "<leader>fld", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
	},
	config = function()
		local telescope = require("telescope")
		
		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = "❯ ",
				sorting_strategy = "ascending",
				layout_config = { horizontal = { prompt_position = "top" } },
				file_ignore_patterns = { "node_modules", ".git/", "*.lock" },
			},
			pickers = {
				find_files = { hidden = true },
				buffers = { sort_lastused = true, theme = "dropdown", previewer = false },
			},
			extensions = {
				fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
				["ui-select"] = { require("telescope.themes").get_dropdown() },
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}
