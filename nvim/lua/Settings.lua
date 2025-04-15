-- UI Settings
vim.cmd.colorscheme("tokyonight-night")  -- Set the colorscheme

-- Debugger
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red' })  -- Custom DAP breakpoint sign

-- General UI/Appearance
vim.opt.termguicolors = true  -- Enable true colors
vim.opt.cursorline = true  -- Highlight the current line
vim.opt.cursorcolumn = true  -- Highlight the current column
vim.opt.scrolloff = 8  -- Keep 8 lines visible above/below the cursor
vim.opt.wrap = true  -- Enable line wrapping
vim.opt.linebreak = true  -- Wrap lines at word boundaries

-- Numbering
vim.opt.nu = true  -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative line numbers

-- Search Settings
vim.opt.ignorecase = true  -- Case-insensitive search
vim.opt.smartcase = true  -- Override case-insensitivity for uppercase letters
vim.opt.hlsearch = true  -- Highlight search results
vim.opt.incsearch = true  -- Incremental search

-- Indentation
vim.opt.tabstop = 4  -- Number of spaces per tab
vim.opt.softtabstop = 4  -- Number of spaces when pressing Tab in insert mode
vim.opt.shiftwidth = 4  -- Number of spaces for auto-indentation
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.smartindent = true  -- Automatically indent based on syntax
vim.opt.breakindent = true  -- Indent wrapped lines for better readability

-- Folding
vim.opt.foldmethod = "expr"  -- Enable folding using expressions
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- Use Treesitter for code folding
vim.opt.foldlevelstart = 20  -- Open most folds by default

-- Backup and Undo
vim.opt.swapfile = false  -- Disable swap files
vim.opt.backup = false  -- Disable backup files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Custom undo directory
vim.opt.undofile = true  -- Enable persistent undo

-- Diagnostic Signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',  -- Error sign
            [vim.diagnostic.severity.WARN] = '',   -- Warning sign
            [vim.diagnostic.severity.HINT] = '',   -- Hint sign
            [vim.diagnostic.severity.INFO] = '',   -- Info sign
        },
    },
})

-- Miscellaneous
vim.g.indent_blankline_filetype_exclude = { 'dashboard' }  -- Exclude 'dashboard' filetype from indent-blankline plugin
vim.g.mapleader = " "  -- Set leader key to space
vim.o.clipboard = "unnamedplus"

