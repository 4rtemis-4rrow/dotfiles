return {
	"SmiteshP/nvim-navic",
	config = function()
		require("nvim-navic").setup({
			highlight = true,
			lsp = {
				auto_attach = false,
			},
		})
	end,
	event = "BufRead",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
}
