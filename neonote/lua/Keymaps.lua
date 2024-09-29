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
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], {desc = 'Navigate To The Split On The Left'})
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], {desc = 'Navigate To The Split Underneath'})
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], {desc = 'Navigate To the Split Above'})
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], {desc = 'Navigate To The Split On The Right'})
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
vim.keymap.set("n", "<TAB>", ":bn<CR>", {desc = 'Next Buffer'})
vim.keymap.set("n", "<S-TAB>", ":bp<CR>", {desc = 'Previous Buffer'})
vim.keymap.set("n", "n", "nzzzv", {desc = 'Next Match'})
vim.keymap.set("n", "N", "Nzzzv", {desc = 'Previous Match'})
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

