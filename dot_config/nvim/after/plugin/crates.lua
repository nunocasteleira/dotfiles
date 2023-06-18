local null_ls = require("null_ls")
local crates = require("crates")

crates.setup({
	null_ls = {
		enabled = true,
		name = "crates.nvim",
	},
})
