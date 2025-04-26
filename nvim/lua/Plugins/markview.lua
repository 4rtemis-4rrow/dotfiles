return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	ft = { "markdown", "quarto" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		render_modes = true,
		anti_conceal = {
			enabled = true,
			-- Which elements to always show, ignoring anti conceal behavior. Values can either be booleans
			-- to fix the behavior or string lists representing modes where anti conceal behavior will be
			-- ignored. Possible keys are:
			--  head_icon, head_background, head_border, code_language, code_background, code_border
			--  dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
			ignore = {
				code_background = true,
				sign = true,
			},
			above = 0,
			below = 0,
		},
		enabled = true,
		injections = {
			gitcommit = {
				enabled = true,
				query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
			},
		},
		checkbox = { checked = { scope_highlight = "@markup.strikethrough" } },
		code = {
			width = "block",
			left_pad = 2,
			right_pad = 4,
		},
		latex = {
			enabled = true,
			render_modes = false,
			converter = "latex2text",
			highlight = "RenderMarkdownMath",
			position = "above",
			top_pad = 0,
			bottom_pad = 0,
		},
	},
}
