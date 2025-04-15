return {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        {'[', "<cmd>AerialPrev<CR>", desc = "next"},
        {']', "<cmd>AerialNext<CR>", desc = "previous"},
        {'<leader>a', "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial"},
    }
}
