require("toggleterm").setup{
    -- size can be a number or function which is passed the current terminal
    size = function(term) -- Corrected from '20 | function(term)'
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
        return 20 -- Added a default return value
    end,

    open_mapping = [[<c-\>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.

    on_create = function(t) end, -- Corrected from 'fun(t: Terminal)' to standard Lua function
    on_open = function(t) end,
    on_close = function(t) end,
    on_stdout = function(t, job, data, name) end, -- Added a body for the function
    on_stderr = function(t, job, data, name) end,
    on_exit = function(t, job, exit_code, name) end,

    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = false, -- when neovim changes its current directory, the terminal will change its own when next opened

    highlights = {
        Normal = {
            guibg = "#1E1E1E", -- Dark background color
        },
        NormalFloat = {
            link = 'Normal' -- Links to Normal for consistent styling
        },
        FloatBorder = {
            guifg = "#5E5E5E", -- Gray foreground for the border
            guibg = "#2E2E2E", -- Slightly lighter background for the border
        },
    },

    shade_terminals = true, -- NOTE: this option takes priority over highlights specified, so if you specify Normal highlights you should set this to false
    shading_factor = -30, -- Changed '<number>' to a default value
    shading_ratio = -3, -- Changed '<number>' to a default value

    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered

    direction = 'horizontal', -- Removed '|', as this is not a valid way to define multiple options
    close_on_exit = true, -- close the terminal window when the process exits
    clear_env = false, -- use only environmental variables from `env`, passed to jobstart()

    -- Change the default shell. Can be a string or a function returning a string
    shell = vim.o.shell,
    auto_scroll = true, -- automatically scroll to the bottom on terminal output

    -- This field is only relevant if direction is set to 'float'
    -- float_opts = {
    --     -- The border key is *almost* the same as 'nvim_open_win'
    --     border = 'single', -- Removed '|' as this isn't a valid way to define options
    --     width = 80, -- Added default value
    --     height = 20, -- Added default value
    --     row = 1, -- Added default value
    --     col = 1, -- Added default value
    --     winblend = 3,
    --     zindex = 1000, -- Added default value
    --     title_pos = 'left', -- Removed '|' as this isn't a valid way to define options
    -- },

    winbar = {
        enabled = false,
        name_formatter = function(term) -- term: Terminal
            return term.name
        end
    },
}
