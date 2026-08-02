vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.0") },
})

local blink = require("blink.cmp")

blink.setup({
    keymap = { preset = "default" },
    fuzzy = { implementation = "prefer_rust" },
    completion = {
        documentation = { auto_show = true },
    },
    cmdline = {
        enabled = true,
        keymap = { preset = "cmdline" },
        completion = { menu = { auto_show = true } },
    },
    snippets = { preset = "mini_snippets" },
})
