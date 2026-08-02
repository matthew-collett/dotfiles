vim.pack.add({
    "https://github.com/folke/snacks.nvim",
})

local snacks = require("snacks")

snacks.setup({
    notifier = { enabled = false },
    input = { enabled = true },
    quickfile = { enabled = true },
    picker = {
        enabled = true,
        matchers = {
            frecency = true,
            cwd_bonus = false,
            sort_empty = true,
        },
        exclude = {
            ".git",
            "node_modules",
            "dist",
            "build",
        },
        formatters = {
            file = {
                filename_first = true,
                filename_only = false,
                icon_width = 2,
            },
        },
        sources = {
            files = { hidden = true },
            grep = { hidden = true },
        },
    },
    dashboard = {
        enabled = true,
        sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
        },
    },
    styles = {
        input = {
            keys = {
                n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
            },
        },
    },
})

-- pickers
vim.keymap.set("n", "<leader>pf", function() snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>pr", function() snacks.picker.recent() end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>pw", function() snacks.picker.grep_word() end, { desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>pg", function() snacks.picker.grep() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>ph", function() snacks.picker.help() end, { desc = "Search help tags" })
vim.keymap.set("n", "<leader>pk", function() snacks.picker.keymaps() end, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>th", function() snacks.picker.colorschemes() end, { desc = "Pick colorscheme" })
vim.keymap.set("n", "<leader>gbr", function() snacks.picker.git_branches() end, { desc = "Pick git branch" })

-- misc
vim.keymap.set("n", "<leader>rn", function() snacks.rename.rename_file() end, { desc = "Rename current file" })
vim.keymap.set("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>D", function() snacks.dashboard.open() end, { desc = "Open dashboard" })
