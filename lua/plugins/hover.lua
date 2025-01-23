return {
	"lewis6991/hover.nvim",
	lazy = true,
	event = "LspAttach",
	keys = function()
		local hover = require("hover")
		return {
			{
				"<leader>lK",
				function()
					hover.hover()
				end,
				desc = "Hover",
			},
			{
				"<leader>lhs",
				function()
					hover.hover_select()
				end,
				desc = "Hover Select",
			},
			{
				"<MouseMove>",
				function()
					hover.hover_mouse()
				end,
				desc = "Mouse Hover",
			},
		}
	end,
	opts = {
		init = function()
			require("hover.providers.lsp")
			require("hover.providers.dap")
			require("hover.providers.diagnostic")
			require("hover.providers.man")
			require("hover.providers.gh")
		end,
		preview_opts = {
			border = "solid",
		},
	},
}
