return {
	{
		"gbprod/yanky.nvim",
		keys = {
			{ mode = { "n", "x" }, "p", "<Plug>(YankyPutAfter)" },
			{ mode = { "n", "x" }, "P", "<Plug>(YankyPutBefore)" },
			{ mode = { "n", "x" }, "gp", "<Plug>(YankyGPutAfter)" },
			{ mode = { "n", "x" }, "gP", "<Plug>(YankyGPutBefore)" },
			{ mode = { "n", "x" }, "y", "<Plug>(YankyYank)" },
			{ "<a-[>", "<Plug>(YankyPreviousEntry)" },
			{ "<a-]>", "<Plug>(YankyNextEntry)" },
			{ "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
			{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
			{ "]P", "<Plug>(YankyPutIndentAfterLinewise)" },
			{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)" },
			{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)" },
			{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)" },
			{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)" },
			{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)" },
			{ "=p", "<Plug>(YankyPutAfterFilter)" },
			{ "=P", "<Plug>(YankyPutBeforeFilter)" },
		},
		opts = {
			highlight = {
				on_put = true,
				-- on_yank = true,
				timer = 500,
			},
			preserve_cursor_position = {
				enabled = true,
			},
			on_substitute = function()
				require("yanky.integration").substitute()
			end,
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = function(_, opts)
			local telescope = require("telescope")
			local map = vim.keymap.set

			-- pcall(telescope.load_extension, "yank_history")

			map("n", "<leader>ty", function()
				telescope.extensions.yank_history.yank_history({
					previewer = false,
					layout_strategy = "cursor",
					layout_config = {
						height = 0.3,
						width = 0.4,
					},
				})
			end, { desc = "Yanky History" })
		end,
	},
}
