return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					require("snacks").rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,

	opts = {

		bigfile = { enabled = true },
		indent = {
			enabled = true,
			indent = {
				hl = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
					"RainbowRed",
				},
			},
			animate = {
				enabled = true,
				style = "out",
				easing = "linear",
				duration = {
					step = 200, -- ms per step
					total = 500, -- maximum duration
				},
			},
			scope = {
				enabled = true, -- enable highlighting the current scope
				priority = 200,
				char = "║",
				underline = true, -- underline the start of the scope
				only_current = false, -- only show scope in the current window
				hl = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
					"RainbowRed",
				},
			},
		},

		scroll = { enabled = true },

		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scratch = { enabled = true },
		scope = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		rename = { enabled = true },
		zen = { enabled = false },
		terminal = { enabled = true },

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
							require("snacks").picker.projects()
						end,
					},

					{
						icon = " ",
						desc = "Create New Project",
						key = "c",
						key_format = " %s",
						action = function()
							vim.cmd("Scaffold")
						end,
					},

					{
						icon = "󰭎 ",
						desc = "Find File",
						key = "f",
						key_format = " %s",
						action = function()
							require("snacks").picker.smart()
						end,
					},

					{
						icon = " ",
						desc = "Recent Files",
						key = "r",
						key_format = " %s",
						action = function()
							require("snacks").picker.recent()
						end,
					},

					{
						icon = "󱩾 ",
						desc = "Find Word",
						key = "w",
						key_format = " %s",
						action = function()
							require("snacks").picker.grep()
						end,
					},

					{
						icon = " ",
						key = "q",
						desc = "Quit",
						action = function()
							vim.cmd("qa")
						end,
					},
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
						require("snacks").gitbrowse()
					end,
				},

				function()
					local in_git = require("snacks").git.get_root() ~= nil
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
	},

	config = function(_, opts)
		require("snacks").setup(opts)
	end,

	keys = {
		{
			"<leader>st",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Todo",
		},

		-- Search --
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Buffers",
		},

		{
			"<leader>fB",
			function()
				require("snacks").picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},

		{
			"<leader>ff",
			function()
				require("snacks").picker.smart()
			end,
			desc = "Find Files",
		},

		{
			"<leader>fg",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Grep",
		},

		{
			"<leader>fp",
			function()
				require("snacks").picker.projects()
			end,
			desc = "Projects",
		},

		{
			"<leader>fr",
			function()
				require("snacks").picker.recent()
			end,
			desc = "Recent",
		},

		{
			"<leader>fu",
			function()
				require("snacks").picker.undo()
			end,
			desc = "Undo History",
		},

		{
			"<leader>fe",
			function()
				require("snacks").explorer()
			end,
			desc = "File Explorer",
		},

		-- Git --
		{
			"<leader>gb",
			function()
				require("snacks").picker.git_branches()
			end,
			desc = "Git Branches",
		},

		{
			"<leader>gd",
			function()
				require("snacks").picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},

		{
			"<leader>gf",
			function()
				require("snacks").picker.git_log_file()
			end,
			desc = "Git Log File",
		},

		{
			"<leader>gF",
			function()
				require("snacks").picker.git_files()
			end,
			desc = "Git Files",
		},

		{
			"<leader>gl",
			function()
				require("snacks").picker.git_log()
			end,
			desc = "Git Log",
		},

		{
			"<leader>gL",
			function()
				require("snacks").picker.git_log_line()
			end,
			desc = "Git Log Line",
		},

		{
			"<leader>gs",
			function()
				require("snacks").picker.git_status()
			end,
			desc = "Git Status",
		},

		{
			"<leader>gS",
			function()
				require("snacks").picker.git_stash()
			end,
			desc = "Git Stash",
		},

		-- LSP --
		{
			"<leader>ld",
			function()
				require("snacks").picker.diagnostics()
			end,
			desc = "Diagnostics",
		},

		{
			"<leader>ls",
			function()
				require("snacks").picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},

		{
			"<leader>lS",
			function()
				require("snacks").picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},

		{
			"<leader>ldf",
			function()
				require("snacks").picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},

		{
			"<leader>lD",
			function()
				require("snacks").picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},

		{
			"<leader>lI",
			function()
				require("snacks").picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},

		{
			"<leader>lr",
			function()
				require("snacks").picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},

		{
			"<leader>ly",
			function()
				require("snacks").picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},

		-- Others --
		{
			"<c-/>",
			function()
				require("snacks").terminal()
			end,
			desc = "Toggle Terminal",
		},

		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},

		{
			"<leader>fs",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
