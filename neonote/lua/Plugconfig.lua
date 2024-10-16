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

markview.setup();

vim.cmd("Markview enableAll");
