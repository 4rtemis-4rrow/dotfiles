return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,

    open_mapping = [[<c-\>]],

    on_create = function(t) end,
    on_open = function(t) end,
    on_close = function(t) end,
    on_stdout = function(t, job, data, name) end,
    on_stderr = function(t, job, data, name) end,
    on_exit = function(t, job, exit_code, name) end,

    hide_numbers = true,
    shade_filetypes = {},
    autochdir = false,

    highlights = {
      Normal = {
        guibg = nil, -- replace <VALUE-HERE> with an actual color or nil
      },
      NormalFloat = {
        link = "Normal"
      },
      FloatBorder = {
        guifg = nil,
        guibg = nil,
      },
    },

    shade_terminals = true,
    shading_factor = -30,
    shading_ratio = -3, -- note: this option might not be used by toggleterm

    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "horizontal",
    close_on_exit = true,
    clear_env = false,

    shell = vim.o.shell,
    auto_scroll = true,

    float_opts = {
      border = "curved",
      width = 100,
      height = 30,
      row = 1,
      col = 1,
      winblend = 3,
      zindex = 50,
      title_pos = "center",
    },

    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end,
    },

    responsiveness = {
      horizontal_breakpoint = 135,
    },
  }
}
