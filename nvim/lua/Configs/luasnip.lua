local ls = require "luasnip"
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.local/share/nvim/lazy/friendly-snippets" } })
ls.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [require('luasnip.util.types').choiceNode] = {
            active = {
                virt_text = { { " « ", "NonTest" } },
            },
        },
    },
}

