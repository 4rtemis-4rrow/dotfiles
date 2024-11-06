vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre", "InsertLeave" }, {
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
