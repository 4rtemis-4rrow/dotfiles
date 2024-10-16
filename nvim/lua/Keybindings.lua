vim.g.mapleader = ' '
vim.keymap.set("n", "Q", "<nop>")

--Plugins--
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {desc = 'Find Files With Telescope'})
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {desc = 'Find File Contents with Telescope'})
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {desc = 'Search Previously Opened Files With Telescope'})
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", {desc = 'View Undo History With Telescope'})
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {desc = 'Buffer Switcher'})
vim.keymap.set("n", "<leader>a", "<cmd>SymbolsOutline<CR>", {desc = 'Toggle Symbol Outline Panel'})

--UI--
vim.keymap.set("n", "<leader>Sv", vim.cmd.vsplit, {desc = 'Split The Editor Vertically'})
vim.keymap.set("n", "<leader>Sh", vim.cmd.split, {desc = 'Split The Editor Horizontally'})
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", {desc = 'Resize The Editor Vertically'})
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", {desc = 'Resize The Editor Vertically'})
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", {desc = 'Resize The Editor Horizontally'})
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", {desc = 'Resize The Editor Horizontally'})

--LSP--
vim.keymap.set('n', "<leader>ld", function() require('telescope.builtin').lsp_definitions() end, {desc = 'Go To The Definition'})
vim.keymap.set('n', "<leader>lc", vim.cmd.CodeActionMenu, {desc = 'Suggest Code Fix'})
vim.keymap.set('n', '<leader>lh', function() vim.lsp.buf.hover() end, {desc = 'Show Info'})
vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, {desc = 'Rename'})
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.formatting() end, {desc = 'Format'})
vim.keymap.set('n', '<leader>lD', function() vim.lsp.buf.declaration() end, {desc = "Jump to declaration"})
vim.keymap.set('n', "<leader>lR", function() require('telescope.builtin').lsp_references() end, {desc="List References"})
vim.keymap.set('n', "<leader>li", function() require('telescope.builtin').lsp_implementations() end, {desc="List Implementations"})
vim.keymap.set('n', "<leader>lC", function() require("telescope.builtin").lsp_incoming_calls() end, {desc="List Incoming Calls"})
vim.keymap.set('n', "<leader>lg", function() require("telescope.builtin").diagnostics() end, {desc="List Diagnostics"})

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
vim.keymap.set('v', 'p', '_dP', {desc = 'Paste'})
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
vim.keymap.set("n", "<TAB>", ":bn<CR>", {desc = 'Next Buffer'})
vim.keymap.set("n", "<S-TAB>", ":bp<CR>", {desc = 'Previous Buffer'})
vim.keymap.set("n", "n", "nzzzv", {desc = 'Next Match'})
vim.keymap.set("n", "N", "Nzzzv", {desc = 'Previous Match'})
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set('n', 'Z', "za")

-- Debugger --
vim.keymap.set('n', '<leader>db', vim.cmd.DapToggleBreakpoint, {desc = 'Toggle Breakpoint'})
vim.keymap.set('n', '<leader>dc', vim.cmd.DapContinue, {desc = 'Start Debuggee'})
vim.keymap.set('n', '<leader>dr', vim.cmd.DapRestartFrame, {desc = 'Restart Debuggee'})
vim.keymap.set('n', '<leader>di', vim.cmd.DapStepInto, {desc = 'Step Into The Function'})
vim.keymap.set('n', '<leader>do', vim.cmd.DapStepOut, {desc = 'Step Out Of The Function'})
vim.keymap.set('n', '<leader>dv', vim.cmd.DapStepOver, {desc = 'Step Over The Function'})
vim.keymap.set('n', '<leader>dk', vim.cmd.DapTerminate, {desc = 'Kill Debuggee'})

-- Git --
vim.keymap.set('n', '<leader>gs', function() require("tinygit").interactiveStaging() end, {desc="Interactively Stage Files"})
vim.keymap.set("n", "<leader>gc", function() require("tinygit").smartCommit() end, {desc="Commit Changes"})
vim.keymap.set("n", "<leader>gp", function() require("tinygit").push() end, {desc="Push Changes"})
vim.keymap.set("n", "<leader>ghs", function() require("tinygit").searchFileHistory() end, {desc="Search File History"})
vim.keymap.set("n", "<leader>ghf", function() require("tinygit").functionHistory() end, {desc="Show Function History"})
vim.keymap.set("n", "<leader>ghl", function() require("tinygit").lineHistory() end, {desc="Show Line History"})
vim.keymap.set("n", "<leader>gsh", function() require("tinygit").stashPush() end, {desc="Stash Push"})
vim.keymap.set("n", "<leader>gsp", function() require("tinygit").stashPop() end, {desc="Stash Pop"})
