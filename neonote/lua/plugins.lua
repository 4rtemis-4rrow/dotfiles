local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.g.mapleader = ' '
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        {
            "OXY2DEV/markview.nvim",
            lazy = false,      -- Recommended
            -- ft = "markdown" -- If you decide to lazy-load anyway

            dependencies = {
                -- You will not need this if you installed the
                -- parsers manually
                -- Or if the parsers are in your $RUNTIMEPATH
                "nvim-treesitter/nvim-treesitter",

                "nvim-tree/nvim-web-devicons"
            }
        },
    },
    "nvim-tree/nvim-tree.lua",
    "jbyuki/venn.nvim",
    "hrsh7th/nvim-cmp",
    'nvim-lualine/lualine.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = 'TSUpdate' },
    'folke/tokyonight.nvim',
    {
        "chrisgrieser/nvim-spider",
        keys = {
            { "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider-w", mode = { "n", "o", "x" } },
            { "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider-e", mode = { "n", "o", "x" } },
            { "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider-b", mode = { "n", "o", "x" } },
            { "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge", mode = { "n", "o", "x" } },
        },
        opts = {
            skipInsignificantPunctuation = true,
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    undo = {
                    },
                },
            })
            require("telescope").load_extension("undo")
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
        end,
    },

    {
        "nvimtools/hydra.nvim",
        config = function()
            -- create hydras in here
        end
    }
})
