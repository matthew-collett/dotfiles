vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
})

local oil = require("oil")

oil.setup({
    view_options = { show_hidden = true },
    skip_confirm_for_simple_edits = true,
    keymaps = {
        ["<C-c>"] = false,
        ["q"] = "actions.close",
    },
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", oil.toggle_float, { desc = "Open parent directory (float)" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function() vim.opt_local.cursorline = true end,
})
