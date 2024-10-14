return {
	"chrisgrieser/nvim-spider",
	keys = function(keys)
		local spider = require("spider")
		return {
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider [e]" },
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider [w]" },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider [b]" },
		}
	end,
	opts = {
		skipInsignificantPunctuation = false,
	}
}
