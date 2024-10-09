return {
	{
		"stevearc/aerial.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		keys = { { "<leader>a", "<CMD>AerialToggle!<CR>", desc = "Aerial Toggle" } },
		opts = {
			layout = { default_direction = "prefer_left", width = 40 },
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		},
	},

	-- NOTE:
	-- Optional config for Telescope integration
	-- This adds the `Telescope aerial` picker
	{
		"nvim-telescope/telescope.nvim",
		opts = function(_, opts)
			opts.extensions = opts.extensions or {}
			opts.extensions.aerial = {}
			table.insert(opts.extensions.aerial, {
				format_symbol = function(symbol_path, filetype)
					if filetype == "json" or filetype == "yaml" then
						return table.concat(symbol_path, ".")
					else
						return symbol_path[#symbol_path]
					end
				end,
				show_columns = "both",
			})
			pcall(require("telescope").load_extension, "aerial")
		end,
	},
}
