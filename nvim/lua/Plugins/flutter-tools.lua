return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
    ft = { 'dart' },
}
