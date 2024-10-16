require'sniprun'.setup({
	display = {
		"VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)
		"VirtualTextErr",
	},

	live_display = { "VirtualTextOk" }, --# display mode used in live_mode

	display_options = {
		terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
		terminal_line_number = false,   --# whether show line number in terminal window
		terminal_signcolumn = false,    --# whether show signcolumn in terminal window
		terminal_position = "vertical", --# or "horizontal", to open as horizontal split instead of vertical split
		terminal_width = 45,          --# change the terminal display option width (if vertical)
		terminal_height = 20,         --# change the terminal display option height (if horizontal)
		notification_timeout = 5      --# timeout for nvim_notify output
	},

	--# You can use the same keys to customize whether a sniprun producing
	--# no output should display nothing or '(no output)'
	show_no_output = {
		"Classic",
		"TempFloatingWindow",  --# implies LongTempFloatingWindow, which has no effect on its own
	},

	--# customize highlight groups (setting this overrides colorscheme)
	--# any parameters of nvim_set_hl() can be passed as-is
	snipruncolors = {
		SniprunVirtualTextOk   =  {bg="#66eeff", fg="#000000", ctermbg="Cyan", ctermfg="Black"},
		SniprunFloatingWinOk   =  {fg="#66eeff", ctermfg="Cyan"},
		SniprunVirtualTextErr  =  {bg="#881515", fg="#000000", ctermbg="DarkRed", ctermfg="Black"},
		SniprunFloatingWinErr  =  {fg="#881515", ctermfg="DarkRed", bold=true},
	},

	live_mode_toggle='off',      --# live mode toggle, see Usage - Running for more info   

	--# miscellaneous compatibility/adjustement settings
	ansi_escape = true,         --# Remove ANSI escapes (usually color) from outputs
	inline_messages = false,    --# boolean toggle for a one-line way to display output
	--# to workaround sniprun not being able to display anything

	borders = 'single',         --# display borders around floating windows
	--# possible values are 'none', 'single', 'double', or 'shadow'
})

