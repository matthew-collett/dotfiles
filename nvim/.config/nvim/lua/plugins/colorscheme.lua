vim.pack.add({
    "https://github.com/olivercederborg/poimandres.nvim",
    { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
    { src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" },
})

local poimandres = require("poimandres")
poimandres.setup({
    disable_background = true,
})
vim.cmd.colorscheme("poimandres")
