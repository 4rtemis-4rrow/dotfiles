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
    { 'nvim-lualine/lualine.nvim',                  event = 'VimEnter' },
    { 'nvim-tree/nvim-web-devicons',                lazy = true },
    { 'MunifTanjim/nui.nvim',                       lazy = true },
    { 'yaocccc/nvim-foldsign',                      event = 'BufReadPre' },
    { 'nvim-neotest/nvim-nio',                      lazy = true },
    { 'm-demare/hlargs.nvim',                       event = 'InsertEnter' },
    { 'kevinhwang91/promise-async',                 lazy = true },
    { 'kevinhwang91/nvim-ufo',                      event = 'BufReadPre' },
    { 'ray-x/guihua.lua',                           lazy = true },
    { 'saadparwaiz1/cmp_luasnip',                   event = 'InsertEnter' },
    { 'Slotos/telescope-lsp-handlers.nvim',         cmd = 'Telescope' },
    { 'rcarriga/nvim-notify',                       event = 'VimEnter' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help',        event = 'InsertEnter' },
    { 'hrsh7th/cmp-path',                           event = 'InsertEnter' },
    { 'HiPhish/rainbow-delimiters.nvim',            event = 'BufReadPre' },
    { 'folke/tokyonight.nvim',                      event = 'VimEnter' },
    { 'simrat39/symbols-outline.nvim',              cmd = 'SymbolsOutline' },
    { 'jghauser/mkdir.nvim',                        event = 'BufWritePre' },
    { 'nvim-telescope/telescope-file-browser.nvim', cmd = 'Telescope' },
    { 'nvim-telescope/telescope-project.nvim',      cmd = 'Telescope' },
    { 'pwntester/octo.nvim',                        cmd = 'Octo' },
    { 'akinsho/toggleterm.nvim',                    version = "*",         config = true, keys = { [[<c-\>]] } },
    { "jbyuki/venn.nvim" },
    { "nvimtools/hydra.nvim" },
    "stevearc/conform.nvim",
    "zapling/mason-conform.nvim",

    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },

    {
        "Fildo7525/pretty_hover",
        event = "LspAttach",
        opts = {}
    },

    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    },

    {
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
        opts = {},
    },
    {
        "stevearc/overseer.nvim",
        commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1
            },
        },
    },

    {
        "luckasRanarison/nvim-devdocs",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        event = "VeryLazy",
        opts = {}
    },

    { 'nvim-treesitter/nvim-treesitter',     build = 'TSUpdate', event = 'BufRead' },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
    },

    {
        "otavioschwanck/arrow.nvim",
        event = 'BufRead',
        opts = {
            show_icons = true,
            leader_key = ';',
            buffer_leader_key = 'm', -- Per Buffer Mappings
        },
    },

    {
        "michaelb/sniprun",
        branch = "master",
        build = "sh install.sh",
        cmd = "SnipRun",
    },

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    },

    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = {
            'DiffviewFileHistory', 'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh'
        }
    },

    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    {
        "chrisgrieser/nvim-spider",
        keys = {
            { "w",  "<cmd>lua require('spider').motion('w')<CR>",  desc = "Spider-w",  mode = { "n", "o", "x" } },
            { "e",  "<cmd>lua require('spider').motion('e')<CR>",  desc = "Spider-e",  mode = { "n", "o", "x" } },
            { "b",  "<cmd>lua require('spider').motion('b')<CR>",  desc = "Spider-b",  mode = { "n", "o", "x" } },
            { "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge", mode = { "n", "o", "x" } },
        },
        opts = {
            skipInsignificantPunctuation = true,
        },
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        opts = {
            handlers = {}
        },
        key = '<leader>dc'
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", 'theHamsta/nvim-dap-virtual-text' },
        event = "VeryLazy",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        key = '<leader>dc'
    },

    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
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

    { "lukas-reineke/indent-blankline.nvim", main = "ibl",       event = "BufRead", opts = {} },

    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter', 'CmdlineEnter' },
        branch = 'v0.6', --recommended as each new version will have breaking changes
        opts = {
            --Config goes here
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        cmd = "Telescope",
        config = function()
            require("telescope").setup({
                extensions = {
                    undo = {
                    },
                },
            })
            require("telescope").load_extension("undo")
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
            require 'telescope'.load_extension('project')
        end,
    },

    {
        'williamboman/mason.nvim',
        lazy = true,
        config = true,
    },

    "mfussenegger/nvim-lint",
    "rshkarin/mason-nvim-lint",

    {
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp",
        event = 'InsertEnter',
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
            }
        },
    },

    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
    },

    {
        'SuperBo/fugit2.nvim',
        opts = {
            width = 70,
            external_diffview = true,
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            {
                'chrisgrieser/nvim-tinygit',
                dependencies = { 'stevearc/dressing.nvim' }
            },
        },
        cmd = { 'Fugit2', 'Fugit2Blame', 'Fugit2Diff', 'Fugit2Graph' },
        keys = {
            { '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' }
        }
    },

    {
        "OXY2DEV/markview.nvim",
        lazy = true,
        ft = { "markdown", "latex" },

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },

})

require("mason").setup()
