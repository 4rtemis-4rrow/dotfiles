return {
    "OXY2DEV/markview.nvim",
    ft = {"latex", "markdown"}, -- If you decide to lazy-load anyway

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config=function()

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
    end
}
