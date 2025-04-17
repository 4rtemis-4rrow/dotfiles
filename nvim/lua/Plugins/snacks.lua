return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Buffer delete",
			mode = "n",
		},
		{
			"<leader>ba",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Buffer delete all",
			mode = "n",
		},
		{
			"<leader>bo",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Buffer delete other",
			mode = "n",
		},
		{
			"<leader>bz",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
			mode = "n",
		},
	},
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			preset = {
				pick = nil,
				---@type snacks.dashboard.Item[]
				keys = {
					{
						icon = " ",
						desc = "Projects",
						key = "p",
						key_format = " %s",
						action = function()
							require("telescope").extensions.project.project({})
						end,
					},
					{
						icon = " ",
						desc = "Create New Project",
						key = "c",
						key_format = " %s",
						action = ":Scaffold",
					},

					{
						icon = "󰮗 ",
						desc = "Find File",
						key = "f",
						key_format = " %s",
						action = "Telescope find_files",
					},
					{
						icon = " ",
						desc = "Recent Files",
						key = "r",
						key_format = " %s",
						action = "Telescope oldfiles",
					},
					{
						icon = "󱩾 ",
						desc = "Find Word",
						key = "w",
						key_format = " %s",
						action = "Telescope live_grep",
					},

					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = "▄ ▄\n"
					.. "         ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄\n"
					.. "         █ ▄ █▄█ ▄▄▄ █ █▄█ █ █\n"
					.. "      ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █\n"
					.. "       ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄\n"
					.. "          █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄\n"
					.. "        ▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █\n"
					.. "        █▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █\n"
					.. "       █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█\n",
			},
			sections = {
				{ section = "header" },
				{
					pane = 2,
					section = "terminal",
					cmd = "colorscript -e square",
					height = 5,
					padding = 1,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{
					pane = 2,
					icon = " ",
					desc = "Browse Repo",
					padding = 1,
					key = "b",
					action = function()
						Snacks.gitbrowse()
					end,
				},
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							title = "Notifications",
							cmd = "gh notify -s -a -n5",
							action = function()
								vim.ui.open("https://github.com/notifications")
							end,
							key = "n",
							icon = " ",
							height = 5,
							enabled = true,
						},
						{
							title = "Open Issues",
							cmd = "gh issue list -L 3",
							key = "i",
							action = function()
								vim.fn.jobstart("gh issue list --web", { detach = true })
							end,
							icon = " ",
							height = 7,
						},
						{
							icon = " ",
							title = "Open PRs",
							cmd = "gh pr list -L 3",
							key = "P",
							action = function()
								vim.fn.jobstart("gh pr list --web", { detach = true })
							end,
							height = 7,
						},
						{
							icon = " ",
							title = "Git Status",
							cmd = "git --no-pager diff --stat -B -M -C",
							height = 10,
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							pane = 2,
							section = "terminal",
							enabled = in_git,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						}, cmd)
					end, cmds)
				end,
				{ section = "startup" },
			},
		},

		explorer = { enabled = false },
		indent = { enabled = true },
		input = {
			enabled = true,
			styles = {
				backdrop = true,
				position = "float",
				border = "rounded",
				title_pos = "center",
				height = 1,
				width = 60,
				relative = "editor",
				noautocmd = true,
				row = 2,
				-- relative = "cursor",
				-- row = -3,
				-- col = 0,
				wo = {
					winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
					cursorline = false,
				},
				bo = {
					filetype = "snacks_input",
					buftype = "prompt",
				},
				--- buffer local variables
				b = {
					completion = false, -- disable blink completions in input
				},
				keys = {
					n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
					i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
					i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
					i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
					i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
					i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
					i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
					q = "cancel",
				},
			},
		},
		picker = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		rename = { enabled = true },
		zen = { enabled = false },
        terminal = {
            enabled = true,

        }
	},
	config = function(_, opts)
		require("snacks").setup(opts)
	end,
    keys = {
        { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    }
}
