return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-telescope/telescope.nvim"},
    },
    event = "LspAttach",
    config = function()
        require('tiny-code-action').setup()
    end,
    keys = {
        {
            "<leader>lc",
            function()
                require("tiny-code-action").code_action()
            end,
            desc = "Trigger Code Action",
            noremap = true,
            silent = true,
        },
    },

}
