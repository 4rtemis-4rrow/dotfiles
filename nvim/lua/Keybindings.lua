vim.g.mapleader = ' '
vim.keymap.set("n", "Q", "<nop>")

--Plugins--

vim.keymap.set('n', '<C-f>', '<Cmd>Neotree toggle<CR>')
vim.keymap.set("n", "<Tab>", vim.cmd.BufferLineCycleNext)
vim.keymap.set('n', '<C-t>', '<Cmd>ToggleTerm<CR>')
vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]], opts)
vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")

--UI--

vim.keymap.set("n", "<leader>sv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>sh", vim.cmd.split)
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
vim.keymap.set("t", "<C-Up>", "<cmd>resize -2<CR>")
vim.keymap.set("t", "<C-Down>", "<cmd>resize +2<CR>")
vim.keymap.set("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

--LSP--

vim.keymap.set('n', "<leader>ld", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set('n', "<leader>lc", vim.cmd.CodeActionMenu)
vim.keymap.set('n', '<leader>lk', function() vim.lsp.buf.hover() end, opts)
vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, opts)
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.formatting() end, opts)
vim.keymap.set('n', "<leader>xx", function() require("trouble").toggle() end, opts)
vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)

--Navigation--

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-w>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('v', 'p', '_dP', opts)
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
vim.keymap.set("n", "<TAB>", ":bn<CR>")
vim.keymap.set("n", "<S-TAB>", ":bp<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- Sniprun --
vim.keymap.set("v", "<leader>x", "<Cmd>'<,'>SnipRun<CR>")

-- Debugger --
vim.keymap.set('n', '<leader>db',function() require("dapui").toggle() end, opts)
vim.keymap.set('n', '<leader>dc', vim.cmd.DapContinue)
vim.keymap.set('n', '<leader>dr', vim.cmd.DapRestartFrame)
vim.keymap.set('n', '<leader>di', vim.cmd.DapStepInto)
vim.keymap.set('n', '<leader>do', vim.cmd.DapStepOut)
vim.keymap.set('n', '<leader>dv', vim.cmd.DapStepOver)
vim.keymap.set('n', '<leader>dk', vim.cmd.DapTerminate)
vim.keymap.set('n', '<leader>dp', vim.cmd.Dap)
