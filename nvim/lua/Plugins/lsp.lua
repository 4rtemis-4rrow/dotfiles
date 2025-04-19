return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
			},
		})
	end,
	keys = {
		{
			"<leader>lh",
			function()
				require("pretty_hover").hover()
			end,
			desc = "Show Info",
		},
		{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
		{ "<leader>lf", vim.lsp.buf.format, desc = "Format" },
	},
}
