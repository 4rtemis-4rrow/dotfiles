return {
	"LukasPietzschmann/boo.nvim",
	keys = {
		{
			"<leader>bb",
			function()
				require("boo").boo()
			end,
			desc = "Open Boo (LSP Info)",
		},
	},
}
