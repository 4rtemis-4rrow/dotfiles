local M = {}

local function default_on_open(term)
  vim.cmd("startinsert")  -- Start in insert mode
  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

-- Function to open a terminal with specified command and options
function M.open_term(cmd, opts)
  opts = opts or {
    size = vim.o.columns * 0.5,
    direction = "float",
    on_open = default_on_open,
    dir = "git_dir",
  }

  local Terminal = require("toggleterm.terminal").Terminal
  local new_term = Terminal:new {
    cmd = cmd,
    dir = opts.dir,
    auto_scroll = false,
    close_on_exit = false,
    on_open = opts.on_open,
    on_exit = opts.on_exit,
  }
  new_term:open(opts.size, opts.direction)
end

-- Function to open GitHub Dash
function M.gh_dash()
  M.open_term("gh dash", { direction = "float" })  -- Call open_term with specific command
end

return M

