return {
	"chrisgrieser/nvim-spider",
	keys = {
		{ "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider [e]" },
		{ "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider [w]" },
		{ "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider [b]" },
	},
	opts = {
		skipInsignificantPunctuation = false,
	},
}
