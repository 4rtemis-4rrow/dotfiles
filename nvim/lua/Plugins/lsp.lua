return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config=function()
        local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
            },
        })
    end,
    keys = {
		{ "<leader>ld", vim.lsp.buf.definition, desc = "Go To The Definition" },
		{
			"<leader>lh",
			function()
				require("pretty_hover").hover()
			end,
			desc = "Show Info",
		},
		{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
		{ "<leader>lf", vim.lsp.buf.format, desc = "Format" },
		{ "<leader>lD", vim.lsp.buf.declaration, desc = "Jump to declaration" },
		{ "<leader>lR", vim.lsp.buf.references, desc = "List References" },
		{ "<leader>li", vim.lsp.buf.implementation, desc = "List Implementations" },
		{ "<leader>lC", vim.lsp.buf.incoming_calls, desc = "List Incoming Calls" },
		{ "<leader>lg", vim.diagnostic.setqflist, desc = "List Diagnostics" },
	},

}
