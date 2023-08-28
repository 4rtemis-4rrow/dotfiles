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
  'nvim-tree/nvim-web-devicons',
  'chentoast/marks.nvim',
  {'romgrk/barbar.nvim', dependencies = 'nvim-web-devicons'},
  'EdenEast/nightfox.nvim',
  'preservim/nerdtree',
  'nvim-pack/nvim-spectre',
  'nvim-treesitter/nvim-treesitter',
  'preservim/tagbar',
  'mbbill/undotree',
  'hrsh7th/cmp-nvim-lsp',
  'folke/tokyonight.nvim',
  'dense-analysis/ale',
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  'williamboman/mason-lspconfig.nvim',
  'lukas-reineke/indent-blankline.nvim',
  'jghauser/mkdir.nvim',
  'm4xshen/autoclose.nvim',
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"} },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    dependencies = {'nvim-lua/plenary.nvim'}
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
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
