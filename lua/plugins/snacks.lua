return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
		return {
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			indent = { enabled = false },
			input = { enabled = true },
			picker = { enabled = false },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		}
	end,
}
