return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").setup({
			init = function()
				require("hover.providers.lsp")
				-- require("hover.providers.dap")
				require("hover.providers.diagnostic")
				require("hover.providers.man")
			end,
			preview_opts = {
				border = "single",
			},
			-- whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = true,
			mouse_providers = {
				"lsp",
			},
			mouse_delay = 1000,
		})

		-- setup keymaps
		vim.keymap.set("n", "<leader>k", require("hover").hover, { desc = "hover" })
		vim.keymap.set("n", "<leader>gk", require("hover").hover_select, { desc = "hover (select)" })
		vim.keymap.set("n", "<c-p>", function()
			require("hover").hover_switch("previous")
		end, { desc = "hover.nvim (previous source)" })
		vim.keymap.set("n", "<c-n>", function()
			require("hover").hover_switch("next")
		end, { desc = "hover.nvim (next source)" })

		-- mouse support
		vim.keymap.set("n", "<mousemove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
		vim.opt.mousemoveevent = true
	end,
}
