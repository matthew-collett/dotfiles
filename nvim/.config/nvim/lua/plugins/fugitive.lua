vim.pack.add({
    "https://github.com/tpope/vim-fugitive",
})

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive full page tab" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff split" })
vim.keymap.set("n", "<leader>gbb", "<cmd>Git blame<cr>", { desc = "Git blame" })
