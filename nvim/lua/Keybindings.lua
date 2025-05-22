-- Disable annoying default bindings
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")

-- Window splitting
vim.keymap.set("n", "<leader>Sv", vim.cmd.vsplit, { desc = "Split the editor vertically" })
vim.keymap.set("n", "<leader>Sh", vim.cmd.split, { desc = "Split the editor horizontally" })

-- Window resizing (normal and terminal mode)
local resize_keys = {
	["<C-Up>"] = "<cmd>resize -2<CR>",
	["<C-Down>"] = "<cmd>resize +2<CR>",
	["<C-Left>"] = "<cmd>vertical resize -2<CR>",
	["<C-Right>"] = "<cmd>vertical resize +2<CR>",
}
for mode, desc in pairs({ n = "Resize editor (normal)", t = "Resize editor (terminal)" }) do
	for key, cmd in pairs(resize_keys) do
		vim.keymap.set(mode, key, cmd, { desc = desc })
	end
end

-- Window navigation
local nav_keys = {
	["<C-h>"] = "h",
	["<C-j>"] = "j",
	["<C-k>"] = "k",
	["<C-l>"] = "l",
}
for mode, cmd_prefix in pairs({ n = "<C-w>", t = "<cmd>wincmd " }) do
	for key, dir in pairs(nav_keys) do
		vim.keymap.set(mode, key, cmd_prefix .. dir .. (mode == "t" and "<CR>" or ""), {
			desc = "Navigate to the split " .. ({
				h = "on the left",
				j = "underneath",
				k = "above",
				l = "on the right",
			})[dir],
		})
	end
end

-- Visual mode: move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Visual mode: indentation
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Search and replace the word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
	desc = "Search and replace word under cursor",
})

-- Paste without losing clipboard
vim.keymap.set("v", "p", "_dP", { desc = "Paste over selection without overwriting clipboard" })

-- Buffer navigation
vim.keymap.set("n", "<TAB>", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-TAB>", ":bp<CR>", { desc = "Previous buffer" })

-- Center search results
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous match centered" })

-- Clear search highlight on escape
vim.keymap.set({ "i", "n" }, "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Escape and clear search highlight" })

-- Folding
vim.keymap.set("n", "Z", "za", { desc = "Toggle fold" })

-- Scroll and center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
