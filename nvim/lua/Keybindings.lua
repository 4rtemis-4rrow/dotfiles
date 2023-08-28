vim.g.mapleader = ' '
vim.keymap.set("n", "Q", "<nop>")

--Plugins--

vim.keymap.set("n", "<C-u>", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<C-z>", vim.cmd.undo)
vim.keymap.set("v", "<C-z>", vim.cmd.undo)
vim.keymap.set("n", "<C-s>", vim.cmd.write)
vim.keymap.set("n", "<C-g>", vim.cmd.TagbarToggle)
vim.keymap.set("n", "<C-t>", vim.cmd.NERDTreeToggle)
vim.keymap.set("n", "<C-f>", vim.cmd.Telescope)
vim.keymap.set("n", "<Tab>", vim.cmd.BufferNext)
vim.keymap.set("n", "<C-n>", vim.cmd.new)
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})

--UI--

vim.keymap.set("n", "<leader>sv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>sh", vim.cmd.split)
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

--LSP--

vim.keymap.set('n', "<leader>ld", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set('n', "<leader>lc", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set('n', '<leader>lk', function() vim.lsp.buf.hover() end, opts)
vim.keymap.set('n', '<leader>ls', function() vim.lsp.buf.signature_help() end, opts)
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

--Debugging--

vim.keymap.set('n', "<leader>db", vim.cmd.DapToggleBreakpoint)
vim.keymap.set('n', "<leader>dc", vim.cmd.DapContinue)
vim.keymap.set('n', "<leader>dn", vim.cmd.DapStepInto)
vim.keymap.set('n', "<leader>do", vim.cmd.DapStepOut)
vim.keymap.set('n', "<leader>dv", vim.cmd.DapStepOver)



