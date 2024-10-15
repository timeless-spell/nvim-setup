return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>Ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Fzf files",
		},
	},
	opts = {},
}
