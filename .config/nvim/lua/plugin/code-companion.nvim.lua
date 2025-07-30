-- need ollama-cli installed
-- This plugin provides a code companion that can assist with code generation, completion, and other AI-driven features.
-- It uses the ollama adapter for interaction with AI models.
-- The configuration includes setting up the model and context size for the ollama adapter.
return {
	"olimorris/codecompanion.nvim",
	opts = {
		strategies = {
			chat = {
				adapter = "ollama",
			},
			inline = {
				adapter = "ollama",
			},
		},
		adapters = {
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					schema = {
						model = {
							default = "gemma3n:e2b",
						},
						num_ctx = {
							default = 20000,
						},
					},
				})
			end,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}
