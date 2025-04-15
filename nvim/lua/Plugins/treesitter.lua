return {
    "nvim-treesitter/nvim-treesitter",
    build=":TSUpdate",
    event="VimEnter",
    config=function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
            sync_install = true,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            rainbow = {
                enable = true,
                disable = { "html" },
                extended_mode = false,
                max_file_lines = nil,
            },
            indent = { enable = true },
            autotag = {
                enable = true,
            },
        }
    end,
}
