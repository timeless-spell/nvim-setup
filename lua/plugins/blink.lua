return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"moyiz/blink-emoji.nvim",
			"mtoohey31/cmp-fish",
			"chrisgrieser/cmp-nerdfont",
			"brenoprata10/nvim-highlight-colors",
		},
		version = "*",
		opts = {
			keymap = {
				preset = "default",
				cmdline = {
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },
					["<CR>"] = { "accept", "fallback" },

					["<S-Tab>"] = { "select_prev", "fallback" },
					["<Tab>"] = { "select_next", "fallback" },

					["<C-y>"] = { "select_and_accept" },

					["<C-p>"] = { "select_prev", "fallback" },
					["<C-n>"] = { "select_next", "fallback" },
				},
			},
			completion = {
				list = {
					selection = {
						preselect = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
					},
				},
				menu = {
					max_height = 20,
					border = "solid",
					winblend = 10,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
							{ "source_name", gap = 1 },
						},
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr then
											icon = icon .. " " .. color_item.abbr
										end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local _, highlight, _ = require("mini.icons").get("lsp", ctx.kind)
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
									end
									return highlight
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = { border = "solid" },
				},
			},
			signature = {
				enabled = true,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "emoji", "fish", "nerdfont" },
				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
					},
					fish = {
						name = "fish",
						module = "blink.compat.source",
					},
					nerdfont = {
						name = "nerdfont",
						module = "blink.compat.source",
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
