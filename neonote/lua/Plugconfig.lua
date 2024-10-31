-- lualine --
local lualine = require('lualine')
local colors = {
    bg       = "#011627",
    fg       = "#acb4c2",
    yellow   = "#ecc48d",
    cyan     = "#7fdbca",
    darkblue = "#82aaff",
    green    = "#21c7a8",
    orange   = "#e3d18a",
    violet   = "#a9a1e1",
    magenta  = "#ae81ff",
    blue     = "#82aaff ",
    red      = "#ff5874",
}
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}
local config = {
    options = {
        component_separators = '',
        section_separators = '',
        theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end
ins_left {
    function()
        return '▊'
    end,
    color = { fg = colors.blue },
    padding = { left = 0, right = 1 },
}
ins_left {
    function()
        return ' '
    end,
    color = function()
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            ['␖'] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            ['␓'] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },
}
ins_left {
    'filesize',
    cond = conditions.buffer_not_empty,
}
ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.magenta, gui = 'bold' },
}
ins_left { 'location' }
ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }
ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
}
ins_left {
    function()
        return '%='
    end,
}
ins_left {
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    color = { fg = colors.cyan, gui = 'bold' },
}
ins_right {
    'o:encoding',
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold' },
}
ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false,
    color = { fg = colors.green, gui = 'bold' },
}
ins_right {
    'branch',
    icon = '',
    color = { fg = colors.violet, gui = 'bold' },
}
ins_right {
    'diff',
    symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
}
ins_right {
    function()
        return '▊'
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
}
lualine.setup(config)

-- noice --
local noice = require("noice")
noice.setup({
    cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {},
        format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = {},
        },
    },
    messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
    },
    popupmenu = {
        enabled = true,
        backend = "nui",
        kind_icons = {},
    },
    redirect = {
        view = "popup",
        filter = { event = "msg_show" },
    },
    commands = {
        history = {
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp",      kind = "message" },
                },
            },
        },
        last = {
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp",      kind = "message" },
                },
            },
            filter_opts = { count = 1 },
        },
        errors = {
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = { error = true },
            filter_opts = { reverse = true },
        },
    },
    notify = {
        enabled = true,
        view = "notify",
    },
    lsp = {
        progress = {
            enabled = true,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30,
            view = "mini",
        },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            ["vim.lsp.util.stylize_markdown"] = false,
            ["cmp.entry.get_documentation"] = false,
        },
        hover = {
            enabled = true,
            silent = false,
            view = nil,
            opts = {},
        },
        signature = {
            enabled = true,
            auto_open = {
                enabled = true,
                trigger = true,
                luasnip = true,
                throttle = 50,
            },
            view = nil,
            opts = {},
        },
        message = {
            enabled = false,
            view = "notify",
            opts = {},
        },
        documentation = {
            view = "hover",
            opts = {
                lang = "markdown",
                replace = true,
                render = "plain",
                format = { "{message}" },
                win_options = { concealcursor = "n", conceallevel = 3 },
            },
        },
    },
    markdown = {
        hover = {
            ["|(%S-)|"] = vim.cmd.help,
            ["%[.-%]%((%S-)%)"] = require("noice.util").open,
        },
        highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
        },
    },
    health = {
        checker = true,
    },
    smart_move = {
        enabled = true,
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
    },
    presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = false,
    },
    throttle = 1000 / 30,
    views = {},
    routes = {},
    status = {},
    format = {},
})

-- tokyonight --
require("tokyonight").setup({
    style = "night",
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
})

-- treesitter --
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"markdown", "markdown_inline"},
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}

-- hydra.nvim --
local Hydra = require("hydra")
local venn_hint_utf = [[
 Arrow^^^^^^  Select region with <C-v>^^^^^^
 ^ ^ _K_ ^ ^  _f_: Surround with box ^ ^ ^ ^
 _H_ ^ ^ _L_  _<C-h>_: ◄, _<C-j>_: ▼
 ^ ^ _J_ ^ ^  _<C-k>_: ▲, _<C-l>_: ► _<C-c>_
]]

-- :setlocal ve=all
-- :setlocal ve=none
Hydra {
  name = 'Draw Utf-8 Venn Diagram',
  hint = venn_hint_utf,
  config = {
    color = 'pink',
    invoke_on_body = true,
    on_enter = function() vim.wo.virtualedit = 'all' end,
  },
  mode = 'n',
  body = '<leader>ve',
  heads = {
    { '<C-h>', 'xi<C-v>u25c4<Esc>' }, -- mode = 'v' somehow breaks
    { '<C-j>', 'xi<C-v>u25bc<Esc>' },
    { '<C-k>', 'xi<C-v>u25b2<Esc>' },
    { '<C-l>', 'xi<C-v>u25ba<Esc>' },
    { 'H', '<C-v>h:VBox<CR>' },
    { 'J', '<C-v>j:VBox<CR>' },
    { 'K', '<C-v>k:VBox<CR>' },
    { 'L', '<C-v>l:VBox<CR>' },
    { 'f', ':VBox<CR>', { mode = 'v' } },
    { '<C-c>', nil, { exit = true } },
  },
}

-- nvim-cmp --
local cmp = require('cmp')

cmp.setup({
    formatting = {
        fields = { 'abbr', 'kind' },
        format = function(entry, vim_item)
            -- Remove kind icons
            vim_item.kind = vim_item.kind  -- Keep only the kind name without icons
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end
    },
    sources = cmp.config.sources({
        { name = 'buffer' },
        { name = 'path' }
    }),
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            select = true,
        }),

        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

-- MarkView --
local markview = require("markview");
local presets = require("markview.presets");

markview.setup({
    checkboxes = presets.checkboxes.nerd,
    headings = presets.headings.glow_center,
    filetypes = { "markdown", "latex" },

    html = {
        enable = true,

        --- Tag renderer for tags that have an
        --- opening & closing tag.
        tags = {
            enable = true,

            --- Default configuration
            default = {
                --- When true, the tag is concealed.
                ---@type boolean
                conceal = false,

                --- Highlight group for the text inside
                --- of the tag
                ---@type string?
                hl = nil
            },

            --- Configuration for specific tag(s).
            --- The key is the tag and the value is the
            --- used configuration.
            configs = {
                b = { conceal = true, hl = "Bold" },
                u = { conceal = true, hl = "Underlined" },
            }
        },

        --- HTML entity configuration
        entities = {
            enable = true,

            --- Highlight group for the rendered entity.
            ---@type string?
            hl = nil
        }
    },

    inline_codes = {
        enable = true,

        --- Primary highlight group. Used by other
        --- options that end with "_hl" when their
        --- values are nil.
        ---@type string
        hl = "MarkviewHeading3",

        --- Left corner, Added before the left padding.
        ---@type string?
        corner_left = nil,

        --- Left padding, Added before the text.
        ---@type string?
        padding_left = nil,

        --- Right padding, Added after the text.
        ---@type string?
        padding_right = nil,

        --- Right corner, Added after the right padding.
        ---@type string?
        corner_right = nil,

        ---@type string?
        corner_left_hl = nil,
        ---@type string?
        padding_left_hl = nil,

        ---@type string?
        padding_right_hl = nil,
        ---@type string?
        corner_right_hl = nil,
    },

    latex = {
        enable = true,

        --- Bracket conceal configuration.
        --- Shows () in specific cases
        brackets = {
            enable = true,

            --- Highlight group for the ()
            ---@type string
            hl = "@punctuation.brackets"
        },

        --- LaTeX blocks renderer
        block = {
            enable = true,

            --- Highlight group for the block
            ---@type string
            hl = "Code",

            --- Virtual text to show on the bottom
            --- right.
            --- First value is the text and second value
            --- is the highlight group.
            ---@type string[]
            text = { " LaTeX ", "Special" }
        },

        --- Configuration for inline LaTeX maths
        inline = {
            enable = true
        },

        --- Configuration for operators(e.g. "\frac{1}{2}")
        operators = {
            enable = true,
            configs = {
                sin = {
                    --- Configuration for the extmark added
                    --- to the name of the operator(e.g. "\sin").
                    ---
                    --- see `nvim_buf_set_extmark()` for all the
                    --- options.
                    ---@type table
                    operator = {
                        conceal = "",
                        virt_text = { { "𝚜𝚒𝚗", "Special" } }
                    },

                    --- Configuration for the arguments of this
                    --- operator.
                    --- Item index is used to apply the configuration
                    --- to a specific argument
                    ---@type table[]
                    args = {
                        {
                            --- Extmarks are only added
                            --- if a config for it exists.

                            --- Configuration for the extmark
                            --- added before this argument.
                            ---
                            --- see `nvim_buf_set_extmark` for more.
                            before = {},

                            --- Configuration for the extmark
                            --- added after this argument.
                            ---
                            --- see `nvim_buf_set_extmark` for more.
                            after = {},

                            --- Configuration for the extmark
                            --- added to the range of text of
                            --- this argument.
                            ---
                            --- see `nvim_buf_set_extmark` for more.
                            scope = {}
                        }
                    }
                }
            }
        },

        --- Configuration for LaTeX symbols.
        symbols = {
            enable = true,

            --- Highlight group for the symbols.
            ---@type string?
            hl = "@operator.latex",

            --- Allows adding/modifying symbol definitions.
            overwrite = {
                --- Symbols can either be strings or functions.
                --- When the value is a function it receives the buffer
                --- id as the parameter.
                ---
                --- The resulting string is then used.
                ---@param buffer integer.
                today = function (buffer)
                    return os.date("%d %B, %Y");
                end
            },

            --- Create groups of symbols to only change their
            --- appearance.
            groups = {
                {
                    --- Matcher for this group.
                    ---
                    --- Can be a list of symbols or a function
                    --- that takes the symbol as the parameter
                    --- and either returns true or false.
                    ---
                    ---@type string[] | fun(symbol: string): boolean
                    match = { "lim", "today" },

                    --- Highlight group for this group.
                    ---@type string
                    hl = "Special"
                }
            }
        },

        subscript = {
            enable = true,

            hl = "MarkviewLatexSubscript"
        },

        superscript = {
            enable = true,

            hl = "MarkviewLatexSuperscript"
        }
    },

    links = {
        enable = true,

        --- Configuration for normal links
        hyperlinks = {
            enable = true,

            --- When true, link texts that start with an emoji
            --- won't have an icon in front of them.
            ---@type boolean
            __emoji_link_compatability = true,

            --- Icon to show.
            ---@type string?
            icon = "󰌷 ",

            --- Highlight group for the "icon".
            ---@type string?
            hl = "MarkviewHyperlink",

            --- Configuration for custom links.
            custom = {
                {
                    --- Pattern of the address.
                    ---@type string
                    match_string = "stackoverflow%.com",

                    --- Icon to show.
                    ---@type string?
                    icon = " ",

                    --- Highlight group for the icon
                    ---@type string?
                    hl = nil
                },
                { match_string = "stackexchange%.com", icon = " " },
            }
        },

        images = {
            enable = true,

            --- When true, link texts that start with an emoji
            --- won't have an icon in front of them.
            ---@type boolean
            __emoji_link_compatability = true,

            --- Icon to show.
            ---@type string?
            icon = "󰥶 ",

            --- Highlight group for the "icon".
            ---@type string?
            hl = "MarkviewImageLink",

            --- Configuration for custom image links.
            custom = {
                {
                    --- Pattern of the address.
                    ---@type string
                    match_string = "%.svg$",

                    --- Icon to show.
                    ---@type string?
                    icon = "󰜡 ",

                    --- Highlight group for the icon
                    ---@type string?
                    hl = nil
                },
            }
        },

        emails = {
            enable = true,

            --- Icon to show.
            ---@type string?
            icon = " ",

            --- Highlight group for the "icon".
            ---@type string?
            hl = "MarkviewEmail",

            --- Configuration for custom emails
            custom = {}
        },

        internal_links = {
            enable = true,

            --- When true, link texts that start with an emoji
            --- won't have an icon in front of them.
            __emoji_link_compatability = true,

            --- Icon to show.
            ---@type string?
            icon = " ",

            --- Highlight group for the "icon".
            ---@type string?
            hl = "MarkviewHyperlink",

            --- Configuration for custom internal links
            custom = {}
        }
    },

    list_items = {
        enable = true,

        --- Amount of spaces that defines an indent
        --- level of the list item.
        ---@type integer
        indent_size = 2,

        --- Amount of spaces to add per indent level
        --- of the list item.
        ---@type integer
        shift_width = 4,

        marker_minus = {
            add_padding = true,

            text = "",
            hl = "MarkviewListItemMinus"
        },
        marker_plus = {
            add_padding = true,

            text = "",
            hl = "MarkviewListItemPlus"
        },
        marker_star = {
            add_padding = true,

            text = "",
            hl = "MarkviewListItemStar"
        },

        --- These items do NOT have a text or
        --- a hl property!

        --- n. Items
        marker_dot = {
            add_padding = true
        },

        --- n) Items
        marker_parenthesis = {
            add_padding = true
        }
    },

    tables = {
        enable = true,

        --- Parts for the table border.
        ---@type { [string]: string[] }
        text = {
            top       = { "╭", "─", "╮", "┬" },
            header    = { "│", "│", "│" },
            separator = { "├", "┼", "┤", "─" },
            row       = { "│", "│", "│" },
            bottom    = { "╰", "─", "╯", "┴" },

            align_left = "╼",
            align_right = "╾",
            align_center = { "╴", "╶",}
        },

        --- Highlight groups for the "parts".
        ---@type { [string]: string[] }
        hls = {
            top       = { "TableHeader", "TableHeader", "TableHeader", "TableHeader" },
            header    = { "TableHeader", "TableHeader", "TableHeader" },
            separator = { "TableHeader", "TableHeader", "TableHeader", "TableHeader" },
            row       = { "TableBorder", "TableBorder", "TableBorder" },
            bottom    = { "TableBorder", "TableBorder", "TableBorder", "TableBorder" },

            align_left = "TableAlignLeft",
            align_right = "TableAlignRight",
            align_center = { "TableAlignCenter", "TableAlignCenter",}
        },

        --- Minimum width of a table cell
        ---@type integer?
        col_min_width = 5,

        --- When true, top & bottom borders aren't drawn
        ---@type boolean
        block_decorator = true,

        --- When true, top & bottom borders are made with
        --- virtual lines instead of virtual text.
        ---@type boolean
        use_virt_lines = true
    }

});

vim.cmd("Markview enableAll");
