local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#F7768E" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E0AF68" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2AC3DE" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FF9E64" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#9ECE6A" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#BB9AF7" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#2ac3de" })
end)
require("ibl").setup {
    indent = { highlight = highlight },
    exclude = { filetypes = { 'dashboard' } }
}

