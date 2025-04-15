return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        -- Define headers outside the setup call
        local headers = {
            {
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
            {
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
                '⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀⠀ ',
                '⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀⠀ ',
                '⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀ ',
                '⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ ',
                '⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀ ',
                '⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀⠀ ',
                '⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄⠀ ',
                '⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿⠀ ',
                '⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸⠀ ',
                '⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈⠀ ',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
                '⠀⠀⠀⠐⢤⣀⣀⢀⣀⣀⣤⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀ ',
                '⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀ ',
            },
        }

        -- Function to select a random header
        local function get_random_header()
            math.randomseed(os.time())
            return headers[math.random(#headers)]
        end

        -- Now call setup
        require('dashboard').setup {
            theme = 'doom',
            config = {
                header = get_random_header(),
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
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
}
