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
    'nvim-lualine/lualine.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'yaocccc/nvim-foldsign',
    'nvim-neotest/nvim-nio',
    'm-demare/hlargs.nvim',
    'kevinhwang91/promise-async',
    'kevinhwang91/nvim-ufo',
    'ray-x/guihua.lua',
    'saadparwaiz1/cmp_luasnip',
    'Slotos/telescope-lsp-handlers.nvim',
    'rcarriga/nvim-notify',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    'HiPhish/rainbow-delimiters.nvim',
    'folke/tokyonight.nvim',
    'mfussenegger/nvim-lint',
    'simrat39/symbols-outline.nvim',
    'jghauser/mkdir.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-project.nvim',
    'pwntester/octo.nvim',
    {'akinsho/toggleterm.nvim', version = "*", config = true},

    {
        "Zeioth/compiler.nvim",
        cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
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
        opts = {}
    },

    { 'nvim-treesitter/nvim-treesitter', build = 'TSUpdate' },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
    },

    {
        "otavioschwanck/arrow.nvim",
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
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },

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
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        opts = {
            handlers = {}
        },
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", 'theHamsta/nvim-dap-virtual-text'},
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
        end
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

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    {
        'altermo/ultimate-autopair.nvim',
        event={'InsertEnter','CmdlineEnter'},
        branch='v0.6', --recommended as each new version will have breaking changes
        opts={
            --Config goes here
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
            require'telescope'.load_extension('project')
        end,
    },

    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            lazy = true,
            config = false,
            init = function()
                vim.g.lsp_zero_extend_cmp = 0
                vim.g.lsp_zero_extend_lspconfig = 0
            end,
        },

        {
            'williamboman/mason.nvim',
            lazy = false,
            config = true,
        },

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
            cmd = {'LspInfo', 'LspInstall', 'LspStart'},
            event = {'BufReadPre', 'BufNewFile'},
            dependencies = {
                {'hrsh7th/cmp-nvim-lsp'},
                {'williamboman/mason-lspconfig.nvim'},
            },
            config = function()
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_lspconfig()

                lsp_zero.on_attach(function(client, bufnr)
                    lsp_zero.default_keymaps({buffer = bufnr})
                end)

                require('mason-lspconfig').setup({
                    ensure_installed = {},
                    handlers = {
                        lsp_zero.default_setup,
                        lua_ls = function()
                            local lua_opts = lsp_zero.nvim_lua_ls()
                            require('lspconfig').lua_ls.setup(lua_opts)
                        end,
                    }
                })
            end
        }
    },

    -- {
    --     "windwp/nvim-autopairs",
    --     config = function() require("nvim-autopairs").setup {} end
    -- },
    --
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
})
