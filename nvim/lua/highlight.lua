vim.api.nvim_set_hl(0, "MarkviewHeading1", { fg = "#f7768e", bg = "#1f1f1f" }) -- Pink text, dark grey background for heading 1
vim.api.nvim_set_hl(0, "MarkviewHeading2", { fg = "#9ece6a", bg = "#1f1f1f" }) -- Green text, dark grey background for heading 2
vim.api.nvim_set_hl(0, "MarkviewHeading3", { fg = "#73daca", bg = "#1f1f1f" }) -- Cyan text, dark grey background for heading 3
vim.api.nvim_set_hl(0, "MarkviewHeading4", { fg = "#2ac3de", bg = "#1f1f1f" }) -- Teal text, dark grey background for heading 4
vim.api.nvim_set_hl(0, "MarkviewHeading5", { fg = "#bb9af7", bg = "#1f1f1f" }) -- Purple text, dark grey background for heading 5
vim.api.nvim_set_hl(0, "MarkviewHeading6", { fg = "#ff9e64", bg = "#1f1f1f" }) -- Orange text, dark grey background for heading 6

-- Sign and Icon Colors matching the heading foreground colors
vim.api.nvim_set_hl(0, "MarkviewHeading2Sign", { fg = "#9ece6a" }) -- Green for sign of heading 2
vim.api.nvim_set_hl(0, "MarkviewHeading3Sign", { fg = "#73daca" }) -- Cyan for sign of heading 3
vim.api.nvim_set_hl(0, "MarkviewHeading4Sign", { fg = "#2ac3de" }) -- Teal for sign of heading 4
vim.api.nvim_set_hl(0, "MarkviewHeading5Sign", { fg = "#bb9af7" }) -- Purple for sign of heading 5
vim.api.nvim_set_hl(0, "MarkviewHeading6Sign", { fg = "#ff9e64" }) -- Orange for sign of heading 6

vim.api.nvim_set_hl(0, "MarkviewHeading2Icon", { fg = "#9ece6a" }) -- Green for icon of heading 2
vim.api.nvim_set_hl(0, "MarkviewHeading3Icon", { fg = "#73daca" }) -- Cyan for icon of heading 3
vim.api.nvim_set_hl(0, "MarkviewHeading4Icon", { fg = "#2ac3de" }) -- Teal for icon of heading 4
vim.api.nvim_set_hl(0, "MarkviewHeading5Icon", { fg = "#bb9af7" }) -- Purple for icon of heading 5
vim.api.nvim_set_hl(0, "MarkviewHeading6Icon", { fg = "#ff9e64" }) -- Orange for icon of heading 6
