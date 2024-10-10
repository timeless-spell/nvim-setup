return {
	"lewis6991/hover.nvim",
	keys = function(_, keys)
		local hover = require("hover")
		return {
			{
				"<leader>K",
				function()
					hover.hover()
				end,
				desc = "Hover",
			},
			{
				"<leader>gK",
				function()
					hover.hover_select()
				end,
				desc = "Hover Select",
			},
			{
				"<mousemove>",
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
			require("hover.providers.gh_user")
		end,
		preview_opts = {
			border = "single",
		},
		mouse_providers = {
			"lsp",
		},
		mouse_delay = 1000,
		preview_window = false,
		title = true,
	},
}
