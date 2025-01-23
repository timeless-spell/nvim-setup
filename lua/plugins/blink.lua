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
		},
		version = "*",
		opts = {
			keymap = {
				preset = "default",
				cmdline = {
					preset = "default",
					-- ["<C-space>"] = { "show" },
					-- ["<C-e>"] = { "hide", "fallback" },
					-- ["<CR>"] = { "accept", "fallback" },
					--
					-- ["<Tab>"] = { "select_next", "fallback" },
					-- ["<S-Tab>"] = { "select_prev", "fallback" },
					--
					-- ["<Up>"] = { "select_prev", "fallback" },
					-- ["<Down>"] = { "select_next", "fallback" },
					-- ["<C-p>"] = { "select_prev", "fallback" },
					-- ["<C-n>"] = { "select_next", "fallback" },
					--
					-- ["<C-b>"] = {},
					-- ["<C-f>"] = {},
				},
			},
			completion = {
				menu = {
					max_height = 20,
					border = "solid",
					winblend = 10,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
							{ "source_name" },
						},
						components = {
							-- NOTE: Still testing this feature
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr then
											kind_icon = color_item.abbr
										end
									end
									return kind_icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)

									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											hl = color_item.abbr_hl_group
										end
									end
									return hl
								end,
							},
						},
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "solid" } },
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
