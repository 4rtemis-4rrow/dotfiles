vim.g.mapleader = ' '
vim.keymap.set("n", "Q", "<nop>")

--Plugins--

vim.keymap.set('n', '<C-t>', '<Cmd>Neotree toggle<CR>')
vim.keymap.set("n", "<C-f>", vim.cmd.Telescope)
vim.keymap.set("n", "<Tab>", vim.cmd.BufferLineCycleNext)

--UI--

vim.keymap.set("n", "<leader>sv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>sh", vim.cmd.split)
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

--LSP--

vim.keymap.set('n', "<leader>ld", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set('n', "<leader>lc", vim.cmd.CodeActionMenu)
vim.keymap.set('n', '<leader>lk', function() vim.lsp.buf.hover() end, opts)
vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, opts)
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.formatting() end, opts)
vim.keymap.set('n', "<leader>xx", function() require("trouble").open() end)

--Navigation--

vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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
vim.keymap.set('n', '<leader>dp', vim.cmd.DapToggleBreakpoint)
