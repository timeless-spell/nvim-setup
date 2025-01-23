return {
	"sainnhe/sonokai",
	lazy = false,
	init = function()
		vim.cmd.colorscheme("sonokai")
	end,
	priority = 1000,
	config = function(_, opts)
		vim.g.sonokai_style = "andromeda"
		vim.g.sonokai_cursor = "green"
		vim.g.sonokai_transparent_background = 2
		vim.g.sonokai_dim_inactive_windows = 1
	end,
}
