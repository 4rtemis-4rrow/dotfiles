local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local Autopair = require('cmp')
Autopair.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
