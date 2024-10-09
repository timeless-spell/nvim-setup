return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	keys = {
		{
			"<leader>mf",
			function()
				require("mini.files").open()
			end,
			desc = "Mini Files Open",
		},
	},
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.cursorword").setup()
		require("mini.move").setup()
		require("mini.surround").setup({
			mappings = {
				add = "msa", -- Add surrounding in Normal and Visual modes
				delete = "msd", -- Delete surrounding
				find = "msf", -- Find surrounding (to the right)
				find_left = "msF", -- Find surrounding (to the left)
				highlight = "msh", -- Highlight surrounding
				replace = "msr", -- Replace surrounding
				update_n_lines = "msn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		})
		require("mini.files").setup({
			options = {
				use_as_default_explorer = false,
			},
		})
	end,
}
