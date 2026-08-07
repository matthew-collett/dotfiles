vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        lua = { "stylua" },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
    conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format whole file or range in visual mode" })
