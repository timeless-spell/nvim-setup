return {
	"lewis6991/hover.nvim",
	keys = {
		{
			"<leader>K",
			function()
				require("hover").hover()
			end,
			desc = "Hover",
		},
		{
			"<leader>gK",
			function()
				require("hover").hover_select()
			end,
			desc = "Hover Select",
		},
		{
			"<mousemove>",
			function()
				require("hover").hover_mouse()
			end,
			desc = "Mouse Hover",
		},
	},
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
