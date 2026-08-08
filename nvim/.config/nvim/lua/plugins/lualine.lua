vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
})

local lualine = require("lualine")

lualine.setup({
    options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "|", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = { "" } } },
        lualine_c = {
            { "diff", colored = true, symbols = { added = "", modified = "", removed = "" } },
            { "filename", file_status = true, path = 1, shorting_target = 40 },
        },
        lualine_x = { "filetype" },
    },
})
