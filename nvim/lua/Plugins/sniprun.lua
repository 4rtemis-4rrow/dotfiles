return {
	"michaelb/sniprun",
	commands = { "SnipRun", "SnipInfo" },
	build = "sh install.sh",
	config = function()
		require("sniprun").setup({
			display = {
				"VirtualTextOk",
				"VirtualTextErr",
			},
		})
	end,
}
