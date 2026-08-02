require('vim._core.ui2').enable({
    enable = true,
    msg = {
        target = "cmd",
        pager = { height = 1 },
        msg   = { height = 0.5, timeout = 4500 },
        dialog = { height = 0.5 },
        cmd    = { height = 0.5 },
    },
})

require("core")
require("plugins")

