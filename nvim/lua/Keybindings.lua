vim.g.mapleader = ' '
vim.keymap.set("n", "Q", "<nop>")

--Plugins--

vim.keymap.set('n', '<C-f>', '<Cmd>Neotree toggle<CR>', {desc = 'Toggle Neotree File Explorer'})
vim.keymap.set('n', '<C-t>', '<Cmd>ToggleTerm<CR>', {desc = 'Toggle Terminal'})
vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]], opts, {desc = 'Toggle Terminal'})
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {desc = 'Find Files With Telescope'})
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {desc = 'Find File Contents with Telescope'})
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {desc = 'Search Previously Opened Files With Telescope'})
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", {desc = 'View Undo History With Telescope'})

--UI--

vim.keymap.set("n", "<leader>sv", vim.cmd.vsplit, {desc = 'Split The Editor Vertically'})
vim.keymap.set("n", "<leader>sh", vim.cmd.split, {desc = 'Split The Editor Horizontally'})
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", {desc = 'Resize The Editor Vertically'})
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", {desc = 'Resize The Editor Vertically'})
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", {desc = 'Resize The Editor Horizontally'})
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", {desc = 'Resize The Editor Horizontally'})

--LSP--

vim.keymap.set('n', "<leader>ld", function() vim.lsp.buf.definition() end, opts, {desc = 'Go To The Definition Of The Symbol Under The Cursor'})
vim.keymap.set('n', "<leader>lc", vim.cmd.CodeActionMenu, {desc = 'Suggest Code Fix'})
vim.keymap.set('n', '<leader>lk', function() vim.lsp.buf.hover() end, opts, {desc = 'Show Info About The Symbol Under The Cursor'})
vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, opts, {desc = 'Rename The Symbol Under The Cursor'})
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.formatting() end, opts, {desc = 'Format The Entire File'})
vim.keymap.set('n', "<leader>xx", function() require("trouble").toggle() end, opts, {desc = 'Show All LSP Messages In Trouble Window'})
vim.keymap.set("n", "<leader>gr", "<cmd> Telescope lsp_references<CR>", {desc = 'List All References To The Symbol Under The Cursor'})
vim.keymap.set("i", "<A-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
vim.keymap.set("s", "<A-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
vim.keymap.set("i", "<A-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
vim.keymap.set("s", "<A-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
vim.keymap.set("n", "<leader>ex", function() require("luasnip").expand() end, {silent = true})

--Navigation--

vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = 'Navigate To The Split On The Left'})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = 'Navigate To The Split Underneath'})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = 'Navigate To the Split Above'})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = 'Navigate To The Split On The Right'})
vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv<CR>", {desc = 'Move Code Block Above'})
vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv", {desc = 'Move Code Block Below'})
vim.keymap.set("v", "<", "<gv", {desc = 'Indent Code Block To The Left'})
vim.keymap.set("v", ">", ">gv", {desc = 'Indent Code Block To The Right'})
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = 'Search And Replace The Word Under The Cursor'})
vim.keymap.set('v', 'p', '_dP', opts, {desc = 'Paste'})
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts, {desc = 'Navigate To The Split On The Left'})
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts, {desc = 'Navigate To The Split Underneath'})
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts, {desc = 'Navigate To the Split Above'})
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts, {desc = 'Navigate To The Split On The Right'})
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
vim.keymap.set("n", "<TAB>", ":bn<CR>", {desc = 'Next Buffer'})
vim.keymap.set("n", "<S-TAB>", ":bp<CR>", {desc = 'Previous Buffer'})
vim.keymap.set("n", "n", "nzzzv", {desc = 'Next Match'})
vim.keymap.set("n", "N", "Nzzzv", {desc = 'Previous Match'})
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })


-- Sniprun --
vim.keymap.set("v", "<leader>x", "<Cmd>'<,'>SnipRun<CR>", {desc = 'Run Selected Code Block'})

-- Debugger --
vim.keymap.set('n', '<leader>db', vim.cmd.DapToggleBreakpoint, {desc = 'Toggle Breakpoint'})
vim.keymap.set('n', '<leader>dc', vim.cmd.DapContinue, {desc = 'Start Debuggee'})
vim.keymap.set('n', '<leader>dr', vim.cmd.DapRestartFrame, {desc = 'Restart Debuggee'})
vim.keymap.set('n', '<leader>di', vim.cmd.DapStepInto, {desc = 'Step Into The Function'})
vim.keymap.set('n', '<leader>do', vim.cmd.DapStepOut, {desc = 'Step Out Of The Function'})
vim.keymap.set('n', '<leader>dv', vim.cmd.DapStepOver, {desc = 'Step Over The Function'})
vim.keymap.set('n', '<leader>dk', vim.cmd.DapTerminate, {desc = 'Kill Debuggee'})
