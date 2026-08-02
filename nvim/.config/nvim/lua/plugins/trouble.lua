vim.pack.add({
    "https://github.com/folke/trouble.nvim",
})

local trouble = require("trouble")
trouble.setup({
    focus = true,
    auto_preview = false,
})

vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble document diagnostics" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Trouble quickfix list" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble location list" })
