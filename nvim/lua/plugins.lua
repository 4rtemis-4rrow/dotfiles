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
    {"folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    }},
    'tamton-aquib/staline.nvim',
    'nvim-tree/nvim-web-devicons',
    "MunifTanjim/nui.nvim",
    'chentoast/marks.nvim',
    'nvim-neo-tree/neo-tree.nvim',
    'nvim-pack/nvim-spectre',
    'onsails/lspkind.nvim',
    'akinsho/bufferline.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = 'TSUpdate' },
    'HiPhish/rainbow-delimiters.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'folke/tokyonight.nvim',
    'dense-analysis/ale',
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    {'akinsho/toggleterm.nvim', version = "*", config = true},
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    },
    {
        'mikesmithgh/kitty-scrollback.nvim',
        enabled = true,
        lazy = true,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        config = function()
            require('kitty-scrollback').setup()
        end,
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
            -- add any options here
        },
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },
    {
        "michaelb/sniprun",
        branch = "master",
        build = "sh install.sh",
        config = function()
            require("sniprun").setup({
            })
        end,
    },
    'williamboman/mason-lspconfig.nvim',
    {
        "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}
    },
    'jghauser/mkdir.nvim',
    'm4xshen/autoclose.nvim',
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
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
})
