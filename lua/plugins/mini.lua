return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	version = false,
	config = function()
		local map = vim.keymap.set

		-- [[ Mini ai ]]
		require("mini.ai").setup()

		-- [[ Mini cursorword ]]
		require("mini.comment").setup()

		-- [[ Mini cursorword ]]
		require("mini.cursorword").setup()

		-- [[ Mini move ]]
		require("mini.move").setup()

		-- [[ Mini surround ]]
		require("mini.surround").setup({
			mappings = {
				add = "msa",
				delete = "msd",
				find = "msf",
				find_left = "msF",
				highlight = "msh",
				replace = "msr",
				update_n_lines = "msn",

				suffix_last = "l",
				suffix_next = "n",
			},
		})

		-- [[ Mini files ]]
		local files = require("mini.files")
		files.setup({
			options = {
				use_as_default_explorer = false,
			},
		})

		map("n", "<leader>mf", function()
			files.open()
		end, { desc = "Mini Files Open" })

		-- [[ Mini starter ]]
		vim.cmd([[:hi MiniStarterHeader guifg=#87C144]])
		local starter = require("mini.starter")
		starter.setup({
			header = require("config.ascii").neovim1,
			-- TODO: Add more items
			items = {
				{
					name = "Load Session",
					action = "lua require('resession').load()",
					section = "Resession",
				},
				{
					name = "Lazy Nvim",
					action = "Lazy",
					section = "Lazy",
				},
				{ name = "Fzf Global", action = "FZF ~", section = "FZF" },
				{
					name = "Find Files",
					action = 'Telescope find_files layout_config={"width":0.95,"preview_width":0.6,"height":0.95}',
					section = "Telescope",
				},
				{
					name = "File Browser",
					action = 'Telescope file_browser file_browser previewer=true layout_strategy=bottom_pane layout_config={"height":0.85}',
					section = "Telescope",
				},
				{
					name = "Recent Files",
					action = 'Telescope oldfiles previewer=false layout_strategy=vertical layout_config={"width":0.8,"prompt_position":"top"}',
					section = "Telescope",
				},
				{
					name = "Config",
					action = 'Telescope find_files cwd=$HOME/.config/nvim layout_config={"width":0.95,"preview_width":0.6,"height":0.95}',
					section = "Neovim",
				},
				{
					name = "Nvim",
					action = 'Telescope file_browser file_browser path=$HOME/.config/nvim previewer=true layout_strategy=bottom_pane layout_config={"height":0.85}',
					section = "Neovim",
				},
			},
			content_hooks = {
				starter.gen_hook.adding_bullet(),
				starter.gen_hook.aligning("center", "center"),
			},
			footer = os.date(),
		})
	end,
}
