return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")
		local utils = require("telescope.utils")
		local actions = require("telescope.actions")
		local map = vim.keymap.set

		telescope.setup({
			defaults = {
				prompt_prefix = "🔎 ",
				selection_caret = "▶️ ",
				entry_prefix = "🔻 ",
				multi_icon = "✔️ ",
				mappings = {
					i = {
						["<c-down>"] = actions.cycle_history_next,
						["<c-up>"] = actions.cycle_history_prev,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					themes.get_dropdown(),
				},
				["file_browser"] = {
					path = "%:p:h",
					cwd_to_path = true,
					layout_strategy = "center",
					layout_config = { height = 0.55, width = 0.45 },
					previewer = false,
					hijack_netrw = true,
					hidden = {
						file_browser = true,
						folder_browser = true,
					},
				},
			},
		})

		-- [[ Telescope extensions ]]
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "file_browser")

		-- [[ Custom Telescope keymaps ]]
		-- `:h telescope.builtin`

		-- [[ File related keymaps ]]
		-- Find files:
		-- search files in the current working directory
		map("n", "<leader>tsf", function()
			builtin.find_files({
				hidden = true,
				layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
			})
		end, { desc = "[S]earch [F]iles" })

		-- search files in the buffer's current working directory
		map("n", "<leader>tsc", function()
			builtin.find_files({
				cwd = utils.buffer_dir(),
				hidden = true,
				layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
			})
		end, { desc = "[S]earch [F]iles (current buffer)" })

		-- Old files:
		-- search recently open files `:h telescope.builtin.oldfiles`
		map("n", "<leader>tof", function()
			builtin.oldfiles({
				previewer = false,
				layout_strategy = "vertical",
				layout_config = { prompt_position = "top", width = 0.9 },
			})
		end, { desc = "[S]earch [O]ld Files" })

		-- Live grep:
		-- `h: telescope.builtin.live_grep`
		map("n", "<leader>tsg", function()
			builtin.live_grep({
				layout_config = { prompt_position = "bottom", width = 0.95, height = 0.95, preview_width = 0.7 },
			})
		end, { desc = "[S]earch by [G]rep" })

		-- Search word under cursor:
		-- `:h telescope.builtin.grep_string`
		map("n", "<leader>tsw", builtin.grep_string, { desc = "[S]earch current [W]ord" })

		-- Fuzzy search in buffer:
		-- `:h telescope.builtin.current_buffer_fuzzy_find`
		map("n", "<leader>t/", function()
			builtin.current_buffer_fuzzy_find({ layout_strategy = "center", windblend = 10, previewer = false })
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Open telescope file browser:
		-- `:h telescope-file-browser`
		map("n", "<leader>tb", function()
			telescope.extensions.file_browser.file_browser({
				cwd = vim.fn.expand("%:p:h"),
				layout_strategy = "bottom_pane",
				layout_config = {
					height = 0.85,
				},
				grouped = true,
				depth = 2,
				hidden = {
					file_browser = true,
					folder_browser = true,
				},
				respect_gitignore = false,
				previewer = true,
			})
		end, { desc = "File [B]rowser" })

		-- [[ Neovim related keymaps ]]
		-- Open quickfix:
		-- `:h telescope.builtin.quickfix`
		map("n", "<leader>tq", function()
			builtin.quickfix({
				layout_strategy = "center",
				prompt_position = "bottom",
				layout_config = { height = 0.5, width = 0.7 },
			})
		end, { desc = "[Q]uiqfix" })

		-- Search open existing buffers:
		-- `:h telescope.builtin.buffers`
		map("n", "<leader>t<leader>", function()
			builtin.buffers({
				previewer = false,
				layout_strategy = "vertical",
				layout_config = { height = 0.75, width = 0.5 },
			})
		end, { desc = "[S]earch Open [B]uffers" })

		-- Search help tags:
		map("n", "<leader>tht", function()
			builtin.help_tags({
				layout_strategy = "bottom_pane",
				layout_config = { prompt_position = "bottom", height = 0.7, preview_width = 0.7 },
			})
		end, { desc = "[H]elp [T]ags" })

		-- Search Neovim config files:
		map("n", "<leader>tsn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim Files" })

		-- Search keymaps:
		-- `:h telescope.builtin.keymaps`
		map("n", "<leader>tsk", function()
			builtin.keymaps({ layout_strategy = "center", layout_config = { width = 0.7, height = 0.5 } })
		end, { desc = "[S]earch [K]eymaps" })

		-- [[ LSP related keymaps ]]

		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		map("n", "gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })

		-- Find references for the word under your cursor.
		map("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("n", "gI", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		map("n", "<leader>tD", builtin.lsp_type_definitions, { desc = "Type [D]efinition" })

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		map("n", "<leader>tds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		map("n", "<leader>tws", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
	end,
}
