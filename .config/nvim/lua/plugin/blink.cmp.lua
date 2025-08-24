return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = { "InsertEnter", "CmdlineEnter" },
	version = "*",
	opts = {
		keymap = {
			preset = "default",
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			accept = {
				create_undo_point = true,
				auto_brackets = {
					enabled = true,
					default_brackets = { "(", ")" },
				},
			},
			menu = {
				enabled = true,
				min_width = 20,
				max_height = 15,
				border = "rounded",
				scrollbar = true,
				auto_show = true,
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 }
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				update_delay_ms = 50,
				treesitter_highlighting = true,
				window = {
					min_width = 15,
					max_width = 80,
					max_height = 25,
					border = "rounded",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
		signature = {
			enabled = true,
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				border = "rounded",
			},
		},
	},
}
