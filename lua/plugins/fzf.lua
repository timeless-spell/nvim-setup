return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = function(_, keys)
		local fzf = require("fzf-lua")

		return {
			{
				"<leader>Ff",
				function()
					fzf.files()
				end,
				desc = "Fzf files",
			},
		}
	end,
	opts = {},
}
