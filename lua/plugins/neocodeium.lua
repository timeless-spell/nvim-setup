return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function(_, opts)
		local neocodeium = require("neocodeium")
		neocodeium.setup({
			filetypes = {
				TelescopePrompt = false,
				["dap-repl"] = false,
			},
		})

		vim.keymap.set("i", "<c-g>", neocodeium.accept, { expr = true, silent = true })
		vim.keymap.set("i", "<c-;>", function()
			neocodeium.cycle()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-,>", function()
			neocodeium.cycle(-1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-x>", neocodeium.clear, { expr = true, silent = true })
	end,
}
