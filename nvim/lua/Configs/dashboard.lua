require('dashboard').setup {
    theme = 'doom',
    config = {
        header = {
            "           ▄ ▄                   ",
            "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
        },
        center = {
            {
                icon = ' ',
                desc = 'Projects',
                key = 'p',
                key_format = ' %s',
                action = function() 
                    require('telescope').extensions.project.project{}
                end
            },
            {
                icon = '󰮗 ',
                desc = 'Find File',
                key = 'f',
                key_format = ' %s',
                action = 'Telescope find_files'
            },
            {
                icon = ' ',
                desc = 'Recent Files',
                key = 'r',
                key_format = ' %s',
                action = 'Telescope oldfiles'
            },
            {
                icon = '󱩾 ',
                desc = 'Find Word',
                key = 'w',
                key_format = ' %s',
                action = 'Telescope live_grep'
            },
            {
                icon = '󰗼 ',
                desc = "Quit",
                key = 'q',
                key_format = ' %s',
                action = 'quit'
            },
        },
        footer = {}
    }
}

