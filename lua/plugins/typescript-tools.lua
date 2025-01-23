return {
	"pmizio/typescript-tools.nvim",
	ft = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},
	opts = function(_, opts)
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		return {
			capabilities = capabilities,
			single_file_support = false,
			root_dir = require("lspconfig.util").root_pattern({ "tsconfig.json" }),
			settings = {
				typescript = require("settings.ts_ls").settings,
				javascript = require("settings.ts_ls").settings,
			},
		}
	end,
}
