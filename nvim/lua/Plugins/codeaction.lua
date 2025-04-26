return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        {
          "folke/snacks.nvim",
        }
    },
    event = "LspAttach",
    opts = {
        pickers = "snacks",
        backend = "delta",
    },
    opts = {},
    keys = {
        { "<leader>lc", function() require("tiny-code-action").code_action() end, desc = "Code Action" },
}
}
