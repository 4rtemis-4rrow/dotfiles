return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "MunifTanjim/nui.nvim"
            },
            opts = { lsp = { auto_attach = true } }
        }
    },
    keys = {
        { "<leader>n", "<cmd>Navbuddy<CR>" }
    },

}
